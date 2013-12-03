class ApplicationController < ActionController::Base
  protect_from_forgery

  def self.can_view? user=nil
    false
  end

  def self.can_crud? user=nil
    false
  end
end
