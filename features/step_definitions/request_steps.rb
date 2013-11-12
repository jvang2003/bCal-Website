Given /the following requests exist/ do |requests_table| #done
    requests_table.hashes.each do |request|
    	request[:time] = Time.now 
        Request.create!(request)
    end
end

When /I view my request history/ do 
	click_link("View requests")
end

When /I filter by (.*)/ do |filter|
	find("option[value='#{filter}']").click
end

Then /I should see room "([^\"]*)" with status "([^\"]*)"/ do |name, status|
	el = page.all('.' + status.downcase, :visible => true)
	el.should_not be_nil
	el.first.native.text.should include status
end

Then /I should not see room "([^\"]*)"/ do |name|
	page.all('td', :text => name).first.should_not be_visible
end