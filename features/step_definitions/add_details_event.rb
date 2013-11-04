Given /^I am logged in as a public user$/ do
  visit '/accounts/public/login'
  fill_in 'user_login', :with => 'public_user'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

When /^I try to reserve a room with calendar (.*)$/ do |calendar|
    click_button(calendar)
end

Then /^I will be able to fill in (.*)$/ do |event_details|
    attributes = calendar.split(%r{,\s*})
    fill_in(:email,:with => attributes[0] )
    fill_in(:dept,:with => attributes[1])
    fill_in("reason", :with => attributes[2])
    fill_in("number of people", :with => attributes[3])
    check("course related") unless attributes[4] == "no"
    check("accept different room") unless attributes[4] == "no"
    click_button("submit")
end
