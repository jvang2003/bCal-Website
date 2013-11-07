Given /the following requests exist/ do |requests_table| #done
    requests_table.hashes.each do |request|
        # Request.create!(request)
    end
end

When /I view my request history/ do 
	click_link("View requests")
end

When /I filter by (.*)/ do |filter|
	find("option[value='#{filter}']").click
end

Then /I should see room "([^\"]*)" with status "([^\"]*)"/ do |name, status|
	el = page.all("tr", :text => name)
	el.should_not be_nil
	el.first.native.text.should include status
end

Then /I should not see room "([^\"]*)"/ do |name|
	page.all("tr", :text => name).should be_nil
end