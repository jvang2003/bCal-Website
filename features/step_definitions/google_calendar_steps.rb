require 'google/api_client'

Then /I should see the event with id "(.*?)" in my google calendar/ do |id|
	request = Request.find id
	event = Event.find id
	cal = request.place
	result = request.place.client.execute(
					:api_method => cal.gcalendar.events.get,
					:parameters => {'calendarId' => cal.email,
									'eventId' => event.google_cal_id},)

	result.status.should == 200
end