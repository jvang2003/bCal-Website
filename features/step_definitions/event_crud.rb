When(/^I create an event with request "(.*?)" and a calendar id "(.*?)"$/) do |request_id, cal_id|
	event = Event.new
	event.request = Request.find request_id
	event.request.calendar = Calendar.find cal_id
	event.request.calendar.update_tokens! :access_token => "ya29.AHES6ZRuK6N3dCEvbGy1Hnpu-s2cHOLmDucNv83GVgSRR5RndsiFuA", :refresh_token => "1/kD5OVTdDepuwED4LS79_d0Ro1B0Y4wMzj9qOMjrkac0"

	event.request.calendar.save
	event.request.save
	event.save
end

