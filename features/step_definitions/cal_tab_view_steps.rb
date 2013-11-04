And /I am on the edit page for "(.*)"/ do |calendar_name|
	visit ("/")	
	click_on("Update" + calendar_name)
end

Then /I should see the embedded calendar/ do
	# assuming we'll inject iframe code into view
	# to embed calendar for "calendar view"
	find(:xpath, '//iframe')
		.attribute["src"]
		.should starts_with?("https://www.google.com/calendar/embed?")
end 