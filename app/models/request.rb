require 'google/api_client'

class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason, :place, :time, :status, :course_related, :accept_different_room, :department, :start_time, :end_time
  attr_accessor :google_format_time

  belongs_to :user
  belongs_to :calendar
  has_one :event

  def summary; return @details;end
  def approved; return status == "approved"; end
end
