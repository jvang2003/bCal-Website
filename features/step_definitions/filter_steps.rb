When /^I try to search by "(.*?)" with "(.*?)"/ do |attri, value|
  visit calendars_path

	# type in value in attr search box
  select attri, :from => :filter
  fill_in "keyword", :with => value

  click_button 'filter_submit'
end

Then /I should see calendar "([^\"]*)"/ do |calendar_name|
  if page.respond_to? :should
    page.should have_content(calendar_name)
  else
    assert page.has_content?(calendar_name)
  end
end