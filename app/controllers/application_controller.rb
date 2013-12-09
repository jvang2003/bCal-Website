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
  include UsersHelper

  private
    def require_login
      unless current_user
        redirect_to sign_in_url(:params => {:return_to => request.original_url}), notice: "Please sign in."
      end
    end
end
