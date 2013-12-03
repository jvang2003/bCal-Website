class ApplicationController < ActionController::Base
  protect_from_forgery

  def self.can_view? user
    false
  end

  def self.can_crud? user
    false
  end
  include SessionsHelper
end
