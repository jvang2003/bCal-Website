Given /^the following users exist:$/ do |users_table|
    users_table.hashes.each do |user|
        user[:role] = User.VALID_ROLES[user[:role]]
        User.create!(user)
    end
end

Given /^I am logged in as a(?:n)? "(.*?)"$/ do |name|
    visit sign_in_path
    fill_in "Calnet", :with => User.find_by_role(User.VALID_ROLES[name]).calnet_id
    click_button "submit_button"
end

def login username
    visit sign_in_path
    fill_in "Calnet", :with => username
    click_button "submit_button"
end


