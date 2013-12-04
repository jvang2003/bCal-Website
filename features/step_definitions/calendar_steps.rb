
Given /(?:|I) am logged in as a dep(?:t|artment)? admin(?:strator)?$/ do
	User.create!(:name => 'DeptAdmin User', :calnet_id => 'testing', :role => 2)
	login 'testing'
end

=begin
Given /the following calendars exist/ do |calendars_table|
	calendars_table.hashes.each do |calendar|
		Calendar.create(calendar)
	end
end
=end

When /I make the calendar (no )?fee(?:s)? required/ do |no_fee_required|
	if no_fee_required
		uncheck("calendar_fee_required")
	else
		check("calendar_fee_required")
	end
	click_button("Update Calendar") #This is assuming we are on the edit page
end

When /I (dis|en)able the calendar/ do |choice|
	if choice == "dis" #is this supposed to be bool or string??
		check("calendar_disabled")
	else
		uncheck("calendar_disabled")
	end
	click_button("Update Calendar")
end

When /I make the visibility of the calendar (public|private)/ do |privacy|
	save_and_open_page
	if privacy == "private"
		# find("option", :text => "Private").click
		select('Private', :from => 'calendar_visibility')
	else
		select('Public', :from => 'calendar_visibility')
	end
	click_button("Update Calendar")
end

Then /calendar "([^\"]*)" should (not )?require a fee/ do |calendar_name, no_fee|
        el = find('#' + 'cal' + Calendar.where(:name => calendar_name).first.id.to_s).find('.fee_required')
	if no_fee
		el.text.should == "No"
	else
		el.text.should == "Yes"
	end
end


Then /calendar "([^\"]*)" should (not )?be disabled/ do |calendar_name, enabled|
	el = find('#' + 'cal' + Calendar.where(:name => calendar_name).first.id.to_s).find('.disabled')
        print(enabled)
	if enabled
		el.text.should == "No"
	else
		el.text.should == "Yes"
	end
end

# check visibility of calendar as admin, otherwise you shouldn't be able to follow link
Then /the visibility of calendar "([^\"]*)" should be (public|private)/ do |calendar_name, privacy|
	el = find('#' + 'cal' + Calendar.where(:name => calendar_name).first.id.to_s).find('.visibility')
	if privacy == "private"
		el.text.should == "Private"
	else
		el.text.should == "Public"
	end
end

# check visibility of calendar as someone who can't view it
Then /I should (not )?see the calendar "([^\"]*)"$/ do |not_visible, calendar_name|
	assert (page.index(calendar_name) == nil) == not_visible
end

