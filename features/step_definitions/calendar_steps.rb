
Given /(?:|I) am logged in as a dep(?:t|artment)? admin(?:strator)?$/ do
	User.create!(:name => 'DeptAdmin User', :calnet_id => 'testing', :role => 2, :email => 'DontEmailMe@noemail.com')
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
	if privacy == "private"
		# find("option", :text => "Private").click
		select('Private', :from => 'calendar_visibility')
	else
		select('Public', :from => 'calendar_visibility')
	end
	click_button("Update Calendar")
end

Then /calendar "([^\"]*)" should (not )?require a fee/ do |calendar_name, no_fee|
    index = -1
 	page.find('thead > tr').all('th').each do |e|
 		index += 1
 		if e.text.downcase == 'fee required'
 			break
 		end
 	end	
 	el = find_row(calendar_name).to_a[index]
	if no_fee
		el.text.should == "No"
	else
		el.text.should == "Yes"
	end
end


Then /calendar "([^\"]*)" should (not )?be disabled/ do |calendar_name, enabled|
	# el = find('#' + 'cal' + Calendar.where(:name => calendar_name).first.id.to_s).find('.disabled')
 #        print(enabled)
 	index = -1
 	page.find('thead > tr').all('th').each do |e|
 		index += 1
 		if e.text.downcase == 'disabled'
 			break
 		end
 	end	
 	el = find_row(calendar_name).to_a[index]
	if enabled
		el.text.should == "No"
	else
		el.text.should == "Yes"
	end
end

# check visibility of calendar as admin, otherwise you shouldn't be able to follow link
Then /the visibility of calendar "([^\"]*)" should be (public|private)/ do |calendar_name, privacy|
	index = -1
 	page.find('thead > tr').all('th').each do |e|
 		index += 1
 		if e.text.downcase == 'visibility'
 			break
 		end
 	end	
 	el = find_row(calendar_name).to_a[index]
	if privacy == 'private'
		el.text.should == "Private"
	else
		el.text.should == "Public"
	end
end

# check visibility of calendar as someone who can't view it
Then /I should (not )?see the calendar "([^\"]*)"$/ do |not_visible, calendar_name|
	assert (page.index(calendar_name) == nil) == not_visible
end

