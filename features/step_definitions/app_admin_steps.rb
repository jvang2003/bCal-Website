Given /I am logged in as an app admin/ do
end

Given /the following roles exist/ do |roles_table| #done
    roles_table.hashes.each do |role|
        User.create!(role)
    end
end

When /I try to add a new user/ do
	visit("/sign_up")
end

When /I fill in (.*)/ do |calnet_id|
	fill_in 'Calnet', :with => calnet_id
	fill_in 'Name', :with => "whatever"
	click_button "Create User"
end

Then /I should see "(.*)" in the list of roles/ do |calnet_id|
	visit(users_path)
end