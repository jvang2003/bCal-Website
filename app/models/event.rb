class Event < ActiveRecord::Base
  belongs_to :request

  after_save :update_gcal

  def serialize
	{
		  'summary' => self.request.summary,
		  'start' => self.request.time,
	}
  end

  def update_gcal
  	if self.request and self.request.approved
	  	client = request.calendar.client
	  	gcal = request.calendar.gcalendar

	  	event = serialize

	  	if google_cal_id != nil
	  		puts "Update"
		  	res =client.execute(:api_method => gcal.events.update,
		  				   :parameters => {'calendarId' => request.calendar.key, 'eventId' => self.google_cal_id},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
		  	puts res
	  	else
	  		puts "Insert"
		  	res = client.execute(:api_method => gcal.events.insert,
		  				   :parameters => {'calendarId' => request.calendar.key},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
		  	puts res
	  	end
	end
  end
end
