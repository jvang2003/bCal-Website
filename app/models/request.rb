require 'google/api_client'

class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason, :place, :start_time, :status, :course_related, :accept_different_room, :department, :finish_time, :email
  attr_accessor :google_format_time

  belongs_to :user
  belongs_to :calendar
  has_one :event

  def summary; return @details;end
  def approved; return status == "approved"; end
  def collision(request)
    crash=false
    if request.status != "rejected"
        if request.time > self.finish_time
            crash=false
        elsif request.finish_time < self.time
            crash=false
        else
            crash=true
        end
    end
    return crash
  end

end
