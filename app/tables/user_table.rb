require 'helpers'

class UserTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :calnet_id
  column :name
  column :role

  common_actions
end
