When /I view the users/ do
	visit("/users")
end

When /I try to change calnet_id of "(.*)" to "(.*)"/ do |old, edited|
	visit(edit_user_path :id => User.where(:calnet_id => old).first.id.to_s)
	fill_in 'Calnet', :with => edited
	click_button "Edit User"
end