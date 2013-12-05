When /^I try to search by "(.*?)" with "(.*?)"/ do |attr, value|
  visit calendars_path

	# type in value in attr search box
  select attr, :from => :filter_select
  fill_in "keyword", :with => value

	# click filter button to filter
  puts find('#filter_submit').inspect
  # find('#filter_submit').click
  # click_on "Filter"
  click_button 'filter_submit'
  puts current_path
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
