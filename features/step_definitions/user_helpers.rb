Given /^the following users exist:$/ do |users_table|
    users_table.hashes.each do |user|
        user[:role] = User.VALID_ROLES[user[:role]]
        User.create!(user)
    end
end

Given /^I am logged in as a(?:n)? "(.*?)"$/ do |name|
    login name
    # fill_in "Calnet", :with =>
    # click_button "submit_button"
end

def login username
    visit sign_in_path
    fill_in 'username', with: username
    fill_in 'password', with: 'any password'
    click_button 'Login'
end


