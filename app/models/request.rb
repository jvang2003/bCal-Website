require 'google/api_client'

class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason, :place, :time, :status, :course_related, :accept_different_room, :department
  attr_accessor :google_format_time

  belongs_to :user
  belongs_to :calendar
  has_one :event

  def summary
    @details
  end

  def approved
  	status == "approved"
  end
end
