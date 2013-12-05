class UserTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :calnet_id
  column :name
  column :role

  actions do
    action do |user|
      link_to "Update", edit_user_path(user), :class => 'btn btn-info update-status'
    end
    action do |user|
      link_to "Delete", user_path(user), :class => 'btn btn-danger update-status', :method => :delete
    end
  end
end
