require 'google/api_client'

class Request < ActiveRecord::Base
  attr_accessible :details, :people, :reason, :place, :time, :status, :course_related, :accept_different_room, :department

  belongs_to :user
  belongs_to :calendar
  has_one :event

  after_save :check_google_cal

  def check_google_cal
  	if @approved
  		self.update_google_cal
  	end
  end

  def update_google_cal
	g_cal_id = self.calendar
	result = RequestHelper::gcal_client.execute(:api_method => GCal::g_calendar.events.update,
					:parameters => {'calendarId' => g_cal_id,
									'eventId' => @google_id},
					:authorization => server_credentials)
  end
end
