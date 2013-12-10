When(/^I create an event with request "(.*?)" and a calendar id "(.*?)"$/) do |request_id, cal_id|
	event = Event.new
	event.request = Request.find request_id
	event.request.place = Calendar.find_by_name cal_id

	event.request.save
	event.save
end

