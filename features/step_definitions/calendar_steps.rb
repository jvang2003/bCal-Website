
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
		uncheck("enabled")
	else
		check("enabled")
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
	cal = Calendar.find(calendar_name)
	cal.fee_required.should == !no_fee
end


Then /calendar "([^\"]*)" should (not )?be disabled/ do |calendar_name, enabled|
	cal = Calendar.find(calendar_name)
	cal.disabled.should == !enabled
end

Then /the visibility of calendar "([^\"]*)" should be (public|private)/ do |calendar_name, privacy|
	cal = Calendar.find(calendar_name)
	if privacy == "private"
		cal.privacy.should == enabled
	else
		cal.privacy.should == !enabled
	end
end









