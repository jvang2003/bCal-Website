
Given /(?:|I) am logged in as a dep(?:t|artment)? admin(?:strator)?$/ do  
	User.create!(:name => 'dept_admin_user', :password => 'testing')
	login('dept_admin_user', 'testing')
end

Given /the following calendars exist/ do |calendars_table|
	calendars_table.hashes.each do |calendar|
		Calendars.create(calendar)	
	end
end 

When /I (?:delete|destroy|remove) calendar "([^\"]*)"$/ do |calendar_name|
	click_button("delete_" + calendar_name)
end

When /I make calendar "([^\"]*)" (no)? fee(?:s)? required/ do |calendar_name, no_fee_required|
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

Then /calendar "([^\"]*)" should (not)? require a fee/ do |calendar_name, no_fee|
	cal = Calendars.find(calendar_name)
	cal.fee_required.should == !no_fee
end

Then /calendar "([^\"]*)" should (not )?be disabled/ do |calendar_name, enabled|
	cal = Calendars.find(calendar_name)
	cal.disabled.should == !enabled
end

Then /I should not see calendar "([^\"]*)"/ do |calendar_name|
	if page.respond_to? :should
		page.should have_content(text)
	else
		assert page.has_content?(text)
	end
end

