class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  def self.can_view? user
    false
  end

  def self.can_crud? user
    false
  end

  include SessionsHelper

  def require_higher_admin
    return if require_login
    @user ||= User.find params[:id]

    if not is_higher_admin? @user
      flash[:error] = "You don't have privileges for user \"#{@user.name}\""
      redirect_back_or calendars_path
    end
  end

  def is_higher_admin? user
    return signed_in? && (current_user.role >= user.role)
  end

  ["App Admin", "Dept Admin", "Admin"].each do |name|
    define_method "require_#{name.to_slug}" do
      if not current_user.send("is_#{name.to_slug}?")
        flash[:error] = "You must be an \"#{name}\" to access this page"
        redirect_to calendars_path
      end
    end
  end
end
