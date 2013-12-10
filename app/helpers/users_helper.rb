module UsersHelper
  def valid_create_roles_for user
    return User.VALID_ROLES.to_a[0, 1] unless user

    index = 0
    arr = User.VALID_ROLES.to_a
    while index < arr.length && arr[index][1] <= user.role
      index += 1
    end
    arr[0,index]
  end

  def is_admin?
    signed_in? and current_user.role > User.VALID_ROLES["Guest"]
  end

  ["App Admin", "Dept Admin", "Admin"].each do |name|
    define_method "is_#{name.to_slug}?" do
      return self.role >= User.VALID_ROLES[name]
    end
  end
end
