Given /the following requests exist/ do |requests_table| #done
    requests_table.hashes.each do |request|
    	request[:start_time] = Time.now
        request[:finish_time] = Time.now
        request["place_id"] = Calendar.find_by_name(request.delete("place")) if request["place"]
        Request.create!(request)
    end
end

When /I view my request history/ do
	click_link "request_index"
end

When /I filter by (.*)/ do |filter|
	find("option[value='#{filter}']").click
end

def find_row name
    rows = page.all('tbody > tr')
    rows.should_not be_nil
    found = false
    rows.each do |row|
        if not found
            data = row.all('td')
            if data.first.text eql? name
                found = data
            end
        end
    end

    found.should_not be false
    return found
end

Then /I should see room "([^\"]*)" with status "([^\"]*)"/ do |name, status|
    row = find_row name
    row.to_a[row.length - 2].text.should == status
end

Then /I should not see room "([^\"]*)"/ do |request|
    page.body.should have_content request
end