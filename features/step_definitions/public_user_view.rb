When /^I try to search by (.*) with "(.*)"/ do |attr, value|
	# type in value in attr search box
	fill_in attr, :with => value
	# click filter button to filter
	click_button 'Filter'
end

Then /I should see calendar "([^\"]*)"/ do |calendar_name|
  if page.respond_to? :should
    page.should have_content(calendar_name)
  else
    assert page.has_content?(calendar_name)
  end
end

Given /that the Google Calendar with API key "(.*)" has been added/ do |key|
	
end
