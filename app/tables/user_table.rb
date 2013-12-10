require 'helpers'
include TableHelpers

class UserTable < TableCloth::Base
  include TableCloth::Extensions::Actions

  column :name
  column :email
  column :role do |user|
    User.VALID_ROLES.key(user.role)
  end

  common_actions
end
