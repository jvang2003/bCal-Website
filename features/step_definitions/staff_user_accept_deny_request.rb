Given /^I am logged in as staff user "(.*?)"$/ do |user_id|
    User.create!(:name => 'Staff User', :calnet_id => 'testing', :role => 1)
    login 'testing'
end

When /^I view all the requests$/ do
    click_link "request_index"
end

When /^I (approve|deny) a request for "(.*?)"$/ do |approve, room|
    click_link "request_index"

    row = find_row room
    row[row.length - 1].click_link "Update"
    select (approve == "approve" ? "Approved" : "Rejected"), :from => "status"
    click_button "Update Status"
end

When /^I edit a request for "(.*)" assuming it was accepted previously$/ do |room|
    step "I approve a request for \"Room 1\""

    row = find_row room
    row[row.length - 1].click_link "Update"
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

