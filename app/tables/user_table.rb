require 'helpers'

class UserTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :calnet_id
  column :name
  column :role do |user|
    User.VALID_ROLES.key(user.role)
  end

  common_actions
end
