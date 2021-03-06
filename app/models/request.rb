require 'google/api_client'

class Request < ActiveRecord::Base
  scope :mine, ->(user_id) do
    where "user_id = ?", user_id
  end
  scope :filter_status, ->(keyword) do
    where "status = ?", keyword
  end


  FIELDS = %w(details people reason place_id start_time status course_related accept_different_room department finish_time user_id email)
  FIELDS.each do |it|
    attr_accessible it
  end
  attr_accessor :google_format_time

  STATUSES = %w(Approved Pending Rejected)

  validates :status, inclusion: Request::STATUSES

  belongs_to :user
  belongs_to :place, :class_name => "Calendar"
  has_one :event

  def summary; return @details;end
  def approved; return status == "approved"; end
  def collision request
    crash = false
    if request.status != "rejected"
        if request.start_time > self.finish_time
            crash = false
        elsif request.finish_time < self.start_time
            crash = false
        else
            crash = true
        end
    end
    return crash
  end

  def email_verify(status)
    if self.status != "Approved" and self.status == "Approved" and self.place.try(:access_token)
      self.event = Event.new
      if self.place.check_collision(self)
          email = self.place.owner.email
          RequestMailer.collision_detected(self.place,email).deliver
      end
      self.event.update_gcal
    elsif status and (self.status == "Rejected" or self.status == "Pending") and self.place.try(:access_token)
      if self.event
        self.event.delete_event
        self.event.destroy
      end
    end
  end
end
