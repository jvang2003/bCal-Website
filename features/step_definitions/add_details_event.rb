Given /^I am logged in as public user "(.*?)"$/ do |user_id|
    User.create!(:name => 'test', :calnet_id => 'test', :role => 0, :email => 'DontEmailMe@noemail.com')
    login 'test'
end

When /^I try to submit a request for reserving a room$/ do
    click_link "request_create"
end

Then /^I will be able to fill in (.*)$/ do |event_details|
    attributes = event_details.split(%r{,\s})
    fill_in(:request_people, :with => attributes[0])
    fill_in(:request_department, :with => attributes[1])
    select(attributes[2], :from => :request_place)
    fill_in(:request_reason, :with => attributes[3])
    fill_in(:request_details, :with => attributes[4])
    fill_in(:date, :with => "12/13/13")

    if attributes[5].downcase == "yes"
        check(:request_course_related)
    elsif attributes[5].downcase == "no"
        uncheck(:request_course_related)
    else
        raise ArgumentError, "must pass in \'yes\' or \'no\' for course_related attr"
    end

    if attributes[6].downcase == "yes"
        check(:request_accept_different_room)
    elsif attributes[6].downcase == "no"
        uncheck(:request_accept_different_room)
    else
        raise ArgumentError, "must pass in \'yes\' or \'no\' for accept_different_room attr"
    end

    click_button("Submit Request")
end
