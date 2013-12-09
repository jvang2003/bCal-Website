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
      return if require_login
      if current_user.role < User.VALID_ROLES[name]
        flash[:alert] = "You must be an \"#{name}\" to access this page"
        redirect_to calendars_path
      end
    end
  end

  def is_higher_admin?
    return if check_signed_in_user?
    @user ||= User.find params[:id]

    if not is_higher_admin_b? @user
      flash[:error] = "You don't have privileges for user \"#{@user.name}\""
      redirect_back_or calendars_path
    end
  end

  def is_higher_admin_b? user
    return signed_in? && (current_user.role >= user.role)
  end
end
