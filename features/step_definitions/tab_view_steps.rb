And /I am viewing(?: the)? calendar "(.*)"/ do |calendar_name|
	visit ("/")	
	click_on(calendar_name)
end

Then /I should see the calendar in tabular form/ do
	# elements are the column names that represent attributes of events
	page.should have_content("Event")
	page.should have_content("Attendees")
	page.should have_content("Start")
	page.should have_content("End")
end

And /I should see the event "(.*)"/ do |name|
	page.should have_content(name)
end


And /I authenticate the calendar "(.*)" the refresh token "(.*)"/ do |calendar_name, refresh_token|
	cal = Calendar.find_by_name(calendar_name)
	auth = cal.client.authorization
	cal.refresh_token = refresh_token
	auth.refresh_token = refresh_token
	auth.fetch_access_token!
	cal.access_token = auth.access_token
	cal.save!
end

# When /I authenticate with the e-mail "(.*)" and pass(?:word)? "(.*)"/ do |email, password| 
# 	click_link("Authenticate")
# 	fill_in("Email",:with => email)
# 	fill_in("Passwd", :with => password)
# 	click_on("signIn")
# 	click_on("submit_approve_access")
# end