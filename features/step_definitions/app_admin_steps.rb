When(/^I view the users$/) do
    visit users_path
end

When(/^I try to add a new user with username "(.*?)"$/) do |name|
    visit new_user_path
    fill_in "user_name", :with => name
    fill_in "user_email", :with => "test@example.com"
    click_button "Create User"
end

When(/^I try to change the name of "(.*?)" to "(.*?)"$/) do |old_name, new_name|
    visit edit_user_path User.find_by_name(old_name).id
    fill_in "user_name", :with => new_name
    click_button "Update User"
end

