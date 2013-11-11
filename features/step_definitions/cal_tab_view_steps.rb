And /I am viewing the calendar "(.*)"/ do |calendar_name|
	visit ("/")	
	click_on(calendar_name)
end

Then /I should see the embedded calendar/ do
	# assuming we'll inject iframe code into view
	# to embed calendar for "calendar view"
	find(:xpath, '//iframe')
		.attribute["src"]
		.should starts_with?("https://www.google.com/calendar/embed?")
end

When /I switch to tabular view/ do
	click_button("Tabular View")
end 

Then /I should see the calendar in tabular form/ do
	# elements are the column names that represent attributes of events
	page.has_content?("Name")
	page.has_content?("Number Attendees")
	page.has_content?("Starting")
	page.has_content?("Ending")
end

When /I switch to calendar view/ do
	click_button("Calendar View")
end