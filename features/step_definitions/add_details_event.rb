Given /^I am logged in as public user "(.*?)"$/ do |user_id|
    User.create!(:name => 'test', :calnet_id => 'test', :role => 0)
    visit("/sign_in")
    fill_in :session_calnet_id, :with => "test"
    click_button 'Sign in'
end

When /^I try to submit a request for reserving a room$/ do
    click_link("Create request")
    #visit("/request/new")
end

Then /^I will be able to fill in (.*)$/ do |event_details|
    attributes = event_details.split(%r{,\s})
    fill_in(:people,:with => attributes[0])
    fill_in(:email,:with => attributes[1] )
    fill_in(:department,:with => attributes[2])
    fill_in("place", :with => attributes[3])
    fill_in("reason", :with => attributes[4])
    fill_in("details", :with => attributes[5])
    check("course_related") unless attributes[6] == "no"
    check("accept different room") unless attributes[7] == "no"
    click_button("Submit Request")
end
