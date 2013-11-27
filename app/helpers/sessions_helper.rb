module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to params[:return_to] || default, :params => params
  end

  def is_admin?
    signed_in? and current_user.role > User.VALID_ROLES["Guest"]
  end

  def is_app_admin?
    if signed_in? and current_user.role < User.VALID_ROLES["App Admin"]
      flash[:error] = "You must be an app admin to access this page"
      redirect_to calendars_path
    end
  end
end