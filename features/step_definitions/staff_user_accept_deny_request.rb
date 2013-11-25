Given /^I am logged in as staff user "(.*?)"$/ do |user_id|
    User.create!(:name => 'staff_user', :password => 'testing')
end

When /^I view all the requests$/ do
    click_link("View requests")
end

When /^I approve a request for "(.*)"$/ do |room|
    click_link("View requests")
    first('.update_status').click_link("Update Status of this request")
    select("Approved", :from => "status")
    click_button("Update Status")
end

When /^I deny a request for "(.*)"$/ do |room|
    click_link("View requests")
    first('.update_status').click_link("Update Status of this request")
    select("Rejected", :from => "status")
    click_button("Update Status")
end

When /^I edit a request for "(.*)" assuming it's accepted previously$/ do |room|
    step "I approve a request for \"Room 1\""
    first('.update_status').click_link("Update Status of this request")
    select("Rejected", :from => "status")
    click_button("Update Status")
end

Then /^I should see all the requests$/ do
    step "I should see room \"Room 1\" with status \"Pending\""
    step "I should see room \"Room 2\" with status \"Pending\""
    step "I should see room \"Room 3\" with status \"Pending\""
end

Then /^I should see the request approved for "(.*)"$/ do |room|
  first('.update_status').click_link("Update Status of this request")
  if page.respond_to? :should
    page.should have_content("Approved")
  else
    assert page.has_content?("Approved")
  end
end

Then /^I should see the request denied for "(.*)"$/ do |room|
   first('.update_status').click_link("Update Status of this request")
   if page.respond_to? :should
     page.should have_content("Rejected")
   else
     assert page.has_content?("Rejected")
   end
end

Then /^I should see the request edited for "(.*)"$/ do |room|
   step "I should see the request denied for \"Room 1\""
end

