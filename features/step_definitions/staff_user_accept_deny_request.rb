Given /^I am logged in as staff user "(.*?)"$/ do |user_id|
    User.create!(:name => 'staff_user', :password => 'testing')
end

When /^I view all the requests$/ do
    click_link("View requests")
end

When /^I approve a request for "(.*)"$/ do |room|
    click_link("View requests")
    click_link(room)
    click("Approve")
    click("Save")
end

When /^I deny a request for "(.*)"$/ do |room|
    click_link("View requests")
    click_link(room)
    click("Deny")
    click("Save")
end

When /^I edit a request for "(.*)" assuming it's accepted previously$/ do |room|
    click_link("View requests")
    click_link(room)
    click("Deny")
    click("Save")
end

Then /^I should see all the requests$/ do
    step "I should see room \"Room 1\" with status \"Pending\""
    step "I should see room \"Room 2\" with status \"Pending\""
    step "I should see room \"Room 3\" with status \"Pending\""
end

Then /^I should see the request approved for "(.*)"$/ do |room|
  click_link(room)
  if page.respond_to? :should
    page.should have_content("Approved")
  else
    assert page.has_content?("Approved")
  end
end

Then /^I should see the request denied for "(.*)"$/ do |room|
    click_link(room)
    if page.respond_to? :should
      page.should have_content("Denied")
    else
      assert page.has_content?("Denied")
    end
end

Then /^I should see the request edited for "(.*)"$/ do |room|
    click_link(room)
    if page.respond_to? :should
      page.should have_content("Approved")
    else
      assert page.has_content?("Approved")
    end
end

