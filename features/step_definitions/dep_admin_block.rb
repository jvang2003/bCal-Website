When /^I try to block "(.*)" from "(.*)" to "(.*)"/ do |calendar, start_time, end_time|
	# not sure about how to block time slots yet
	# check start_time less than end_time
	visit("/")
end

Then /^"(.*)" should not be able to be booked from "(.*)" to "(.*)"/ do |calendar, start_time, end_time|
	# not sure about how to block time slots yet
	# check start_time less than end_time
	visit("/")
end


