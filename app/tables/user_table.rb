class UserTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :calnet_id
  column :name
  column :role

  actions do
    action do |user|
      link_to "Update", edit_user_path(user), :class => 'btn btn-info update-status', :id => "update_#{user.id}"
    end
    action do |user|
      link_to "Delete", user_path(user), :class => 'btn btn-danger update-status', :method => :delete, :id => "delete_#{user.id}"
    end
  end
end
