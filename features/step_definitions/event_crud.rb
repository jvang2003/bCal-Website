When(/^I create an event with request "(.*?)" and google calendar id "(.*?)"$/) do |request_id, cal_id|
	Event.create! :request_id => request_id, :google_cal_id => cal_id
end

