Given /I am logged in as an app admin/ do
	visit("/sign_in")
	fill_in :session_calnet_id, :with => "bob"
	click_button 'Sign in'
	save_and_open_page
end

Given /the following roles exist/ do |roles_table| #done
    roles_table.hashes.each do |role|
        User.create!(role)
    end
end

When /I view the users/ do
	visit("/users")
end

When /I try to add a new user/ do
	visit("/sign_up")
end

When /I fill in (.*)/ do |calnet_id|
	save_and_open_page
	fill_in 'Calnet', :with => calnet_id
	fill_in 'Name', :with => "whatever"
	click_button "Create User"
end

Then /I should (not )?see "(.*)" in the list of roles/ do |nope, calnet_id|
	visit(users_path)
	if nope
		page.text.should_not include(calnet_id)
	else
		page.text.should include(calnet_id)
	end
end

When /I try to delete user "(.*)"/ do |calnet_id|
	click_link "delete_" + User.where(:calnet_id => calnet_id).first.id.to_s
	visit(users_path)
end

When /I try to change calnet_id of "(.*)" to "(.*)"/ do |old, edited|
	visit(edit_user_path :id => User.where(:calnet_id => old).first.id.to_s)
	# save_and_open_page
	fill_in 'Calnet', :with => edited
	click_button "Edit User"
end