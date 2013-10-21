
Given /(?:|I) am logged in as a dep(?:t|artment)? admin(?:strator)?$/ do  
	User.create!(:name => 'dept_admin_user', :password => 'testing')
	login('dept_admin_user', 'testing')
end

Given /the following calendars exist/ do |calendars_table|
	calendars_table.hashes.each do |calendar|
		Calendar.create(calendar)	
	end
end 


When /I make calendar "([^\"]*)" (no )?fee(?:s)? required/ do |calendar_name, no_fee_required|
	if no_fee_required
		uncheck(calendar_name + "_fee_required")
	else
		check(calendar_name + "_fee_required")
	end
	click_button("update_" + calendar_name)
end

When /I (dis|en)able calendar "([^\"]*)"/ do |choice, calendar_name|
	if choice == "en"
		uncheck(calendar_name + "_disabled")
	else
		check(calendar_name + "_disabled")
	end
	click_button("update_" + calendar_name)
end

When /I make the visibility of calendar "([^\"]*)" (public|private)/ do |calendar_name, privacy|
	if privacy == "private"
		check(calendar_name + "_privacy")
	else
		uncheck(calendar_name + "privacy")
	end
	click_button("update_" + calendar_name)
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









