And /I am on the edit page for "(.*)"/ do |calendar_name|
	visit ("/")	
	click_on("Update " + calendar_name)
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
	# elements are the columns of attributes of events
	page.has_content?("Name")
	page.has_content?("Number Attendees")
	page.has_content?("Date-Time")
end

When /I switch to calendar view/ do
	click_button("Calendar View")
end