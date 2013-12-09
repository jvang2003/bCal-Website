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
  private
    def require_login
      unless current_user
        flash[:notice]="You need to sign in to continue"
        redirect_to "/sign_in"
      end
    end
end
