module UsersHelper
  def valid_create_roles_for user
    index = 0
    arr = User.VALID_ROLES.to_a
    while arr[index][1] <= user.role
      index += 1
    end
    return arr[0,index]
  end

  def check_signed_in_user?
    unless signed_in? or is_same_controller_and_action?(request.original_url, sign_up_path)
      puts "uh oh"
      redirect_to sign_in_url(:params => {:return_to => request.original_url}), notice: "Please sign in."
    else
      nil
    end
  end

  def is_admin?
    signed_in? and current_user.role > User.VALID_ROLES["Guest"]
  end

  ["App Admin", "Dept Admin"].each do |name|
    define_method "is_#{name.to_slug}?" do
      return if check_signed_in_user?
      if current_user.role < User.VALID_ROLES[name]
        flash[:error] = "You must be an \"#{name}\" to access this page"
        redirect_to calendars_path
      end
    end
  end

  def is_higher_admin?
    logger.info "hihi"
    @user ||= User.find params[:id]
    return if check_signed_in_user?
    logger.info "hihi"

    if not is_higher_admin_b? @user
      flash[:error] = "You don't have privileges for user \"#{@user.name}\""
      redirect_back_or calendars_path
    end
  end

  def is_higher_admin_b? user
    return signed_in? && (current_user.role >= user.role)
  end
end
