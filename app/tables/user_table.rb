require 'helpers'

class UserTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :calnet_id
  column :name
  column :role

  update_delete_actions
end
