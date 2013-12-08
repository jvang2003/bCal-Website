Given /^I am logged in as public user "(.*?)"$/ do |user_id|
    User.create!(:name => 'test', :calnet_id => 'test', :role => 0)
    login 'test'
end

When /^I try to submit a request for reserving a room$/ do
    click_link "request_create"
end

Then /^I will be able to fill in (.*)$/ do |event_details|
    attributes = event_details.split(%r{,\s})
    fill_in(:request_people,:with => attributes[0])
    fill_in(:request_email,:with => attributes[1] )
    fill_in(:request_department,:with => attributes[2])
    fill_in("request_place", :with => attributes[3])
    fill_in("request_reason", :with => attributes[4])
    fill_in("request_details", :with => attributes[5])
    fill_in("date", :with => "12/13/13")
    check("request_course_related") unless attributes[6] == "no"
    check("request_accept different room") unless attributes[7] == "no"
    click_button("Submit Request")
end
