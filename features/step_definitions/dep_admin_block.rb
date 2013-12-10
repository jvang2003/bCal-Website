When /^I try to block "(.*)" on "(.*)" from "(.*)" to "(.*)"/ do |calendar, date, start_time, end_time|
	# not sure about how to block time slots yet
	# check start_time less than end_time
	click_link "#{calendar}"
	click_link "Create blocked time"
	fill_in 'Date', :with => "#{date}"
	start_hour = start_time.split(":").first
	start_min = start_time.split(":").last
	end_hour = end_time.split(":").first
	end_min = end_time.split(":").last
	if start_min == "00"
		start_min = "0"
	end
	if end_min == "00"
		end_min = "0"
	end

	page.find(:xpath, '//input[@id="startHour"]').set start_hour
	page.find(:xpath, '//input[@id="startMin"]').set start_min
	page.find(:xpath, '//input[@id="endHour"]').set end_hour
	page.find(:xpath, '//input[@id="endMin"]').set end_min

end

Then /^"(.*)" should not be able to be booked on "(.*)" from "(.*)" to "(.*)"/ do |calendar, date, start_time, end_time|
	# not sure about how to block time slots yet
	# check start_time less than end_time
	visit("/")
end


