
Given /(?:|I) am logged in as a dep(?:t|artment)? admin(?:strator)?$/ do  
	User.create!(:name => 'dept_admin_user', :password => 'testing')
	login('dept_admin_user', 'testing')
end

Given /the following calendars exist/ do |calendars_table|
	calendars_table.hashes.each do |calendar|
		Calendar.create(calendar)	
	end
end 


When /I make the calendar (no )?fee(?:s)? required/ do |no_fee_required|
	if no_fee_required
		uncheck("fee_required")
	else
		check("fee_required")
	end
	click_button("Send") #This is assuming we are on the edit page
end

When /I (dis|en)able the calendar/ do |choice|
	if choice == "true" #is this supposed to be bool or string??
		check("disabled")
	else
		uncheck("disabled")
	end
	click_button("Send")
end

When /I make the visibility of the calendar to (public|private)/ do |privacy|
	if privacy == "Private"
		check("visib")
	else
		uncheck("visib")
	end
	click_button("Send")
end

Then /calendar "([^\"]*)" should (not )?require a fee/ do |calendar_name, no_fee|
	visit path_to(calendar_name)
	if no_fee
		page.index("no fee required").should != nil
	else
		page.index("no fee required").should == nil
	end
end


Then /calendar "([^\"]*)" should (not )?be disabled/ do |calendar_name, enabled|
	visit path_to(calendar_name)
	if enabled
		page.index("disabled").should == nil
	else
		page.index("disabled").should != nil
	end
end

# check visibility of calendar as admin, otherwise you shouldn't be able to follow link
Then /the visibility of calendar "([^\"]*)" should be (public|private)/ do |calendar_name, privacy|
	visit path_to(calendar_name)
	if privacy == "private"
		page.index("private").should != nil
	else
		page.index("private").should == nil
	end
end

# check visibility of calendar as someone who can't view it
Then /I should (not )?see the calendar "([^\"]*)"/ do |not_visible, calendar_name|
	assert (page.index(calendar_name) == nil) == not_visible
end

