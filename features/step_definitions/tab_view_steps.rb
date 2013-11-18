And /I am viewing the calendar "(.*)"/ do |calendar_name|
	visit ("/")	
	click_on(calendar_name)
end

Then /I should see the calendar in tabular form/ do
	# elements are the column names that represent attributes of events
	page.should have_content("Name")
	page.should have_content("Number Attendees")
	page.should have_content("Starting")
	page.should have_content("Ending")
end

And /I should see the event "(.*)" on "(.*)"/ do |name, date|
	page.should have_content(name)
	page.should have_content(date)
end

Given /I have authenticated "(.*)" from "(.*)" with the code "(.*)"/ do |name, email, code|
    new_cal = Calendar.create!(name: name, email: email)
    new_cal.access_token = code
end