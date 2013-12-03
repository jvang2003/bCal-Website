Then /^I should (not )?see "(.*)" in the list of (.*?)$/ do |nope, calnet_id, list_type|
    # for now do nothing with the list type :D
    if list_type.downcase == "users"
        visit users_path
    elsif list_type.downcase == "roles"
        visit new_user_path
    end
    page.text.send("should#{"_not" if nope}", include(calnet_id))
end

When /^I try to delete user "(.*)"$/ do |calnet_id|
    found = User.find_by_calnet_id calnet_id
    click_link "delete_" + found.id.to_s
    visit users_path
end

When /I create a user with calnet "(.*?)" name "(.*?)" role "([0-9]+)"/ do |calnet_id, name, role|
    visit new_user_path
    fill_in 'Calnet', :with => calnet_id
    fill_in 'Name', :with => name
    find("option[value=\"#{role.to_i}\"]").click
    click_button "Create User"
end

When /^I try to edit the user named "(.*)"$/ do |calnet_id|
    visit edit_user_path(:id => User.find_by_calnet_id(calnet_id).id.to_s)
end

When /I try to change their calnet_id to "(.*)"/ do |edited|
    fill_in 'Calnet', :with => edited
    click_button "Edit User"
end