Given /^the following users exist:$/ do |users_table|
    users_table.hashes.each do |user|
        user[:role] = User::VALID_ROLES[user[:role]] if not user[:role].kind_of? Fixnum
        User.create!(user)
    end
end

Given /^I am logged in as a(?:n)? "(.*?)"$/ do |role|
    user = User.find_by_role(User::VALID_ROLES[role])
    if user
        login User.find_by_role(User::VALID_ROLES[role]).calnet_id
    else
        user_params = {}
        user_params[:role] = role
        user_params[:calnet_id] = "tester"  
        user_params[:name] = "tester"
        user_params[:email] = "tester@fakeDomain.com"
        login "tester"
    end
end

Given /^I am logged in as? "(.*?)"$/ do |name|
    login name
end

def login username
    visit sign_in_path
    fill_in 'Username', with: username
    fill_in 'Password', with: 'any password'
    click_button 'Login'
end


