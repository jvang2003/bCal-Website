require 'google/api_client'

Then /I should see the event with id "(.*?)" in my google calendar/ do |id|
	request = Request.find id
	event = Event.find id
	result = request.place.client.execute(
					:api_method => request.place.gcalendar.events.get,
					:parameters => {'calendarId' => request.place.email,
									'eventId' => event.google_cal_id},)

	result.status.should == 200
end