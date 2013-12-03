String.class_eval do
  def to_slug
    value = self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    value.gsub!(/[']+/, '')
    value.gsub!(/\W+/, ' ')
    value.strip!
    value.downcase!
    value.gsub!(' ', '_')
    value
  end
end

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

  ["App Admin", "Dept Admin"].each do |name|
    slugified = name.to_slug
    define_method "is_#{slugified}?" do
      if signed_in? and current_user.role < User.VALID_ROLES[name]
        flash[:error] = "You must be an \"#{name}\" to access this page"
        redirect_to calendars_path
      end
    end
  end
end

