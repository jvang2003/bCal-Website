require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

Given /the Google Calendar API is initialized/ do
	# Implementation specific code here
	# Our client has a special way of getting information about the google Calendars, so I'm not
	# sure if we're going to use the traditional Google Calendar API way of getting at data

end

Then /I should see the event with title "[^"]*" in my google calendar/ do |title|
	#Implementation specific code here
	event = Event.find_by_title(title)
	g_cal_id = event.request.calendar
	result = @client.execute(:api_method => @calendar.events.show,
					:parameters => {'calendarId' => g_cal_id,
									'eventId' => event.google_calendar_id},
					:authorization => server_credentials)
	result.data.summary.should contain title
end