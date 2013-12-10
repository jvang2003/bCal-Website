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

    # use hidden fields to bypass slider time-selector
    # and pick time from 2:00 to 3:30
    find_by_id("startHour").set attributes[3]
    find_by_id("startMin").set attributes[4]
    find_by_id("endHour").set attributes[5]
    find_by_id("endMin").set attributes[6]

    fill_in(:request_reason, :with => attributes[7])
    fill_in(:request_details, :with => attributes[8])
    fill_in(:date, :with => "12/13/13")

    if attributes[9].downcase == "yes"
        check(:request_course_related)
    elsif attributes[9].downcase == "no"
        uncheck(:request_course_related)
    else
        raise ArgumentError, "must pass in \'yes\' or \'no\' for course_related attr"
    end

    if attributes[10].downcase == "yes"
        check(:request_accept_different_room)
    elsif attributes[10].downcase == "no"
        uncheck(:request_accept_different_room)
    else
        raise ArgumentError, "must pass in \'yes\' or \'no\' for accept_different_room attr"
    end

    click_button("Submit Request")
end
