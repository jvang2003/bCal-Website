Given /the following requests exist/ do |requests_table| #done
    requests_table.hashes.each do |request|
    	request[:start_time] = Time.now
        request[:finish_time] = Time.now
        request["place_id"] = Calendar.find_by_name(request.delete("place")).id if request["place"]
        request["user_id"] = User.find_by_calnet_id(request.delete("user")).id if request["user"]
        Request.create!(request)
    end
end

When /I view my request history/ do
	click_link "request_index"
end

When /I filter by (.*)/ do |filter|
	find("option[value=\"#{filter}\"]").click
end

def find_row_for_room room_name
    room_id = Calendar.find_by_name(room_name).id.to_s

    rows = page.all('tbody > tr')
    rows.should_not be_nil
    found = false
    rows.each do |row|
        if not found
            data = row.all('td')
            if data.first.text == name
                found = data
            end
        end
    end

    found.should_not be false
    return found
end

Then /I should see room "([^\"]*)" with status "([^\"]*)"/ do |name, status|

    row = find_row_for_room name
    row.to_a[3].text.should == status
end

Then /I should not see room "([^\"]*)"/ do |request|
    page.body.should have_content request
end