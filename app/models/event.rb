class Event < ActiveRecord::Base
  belongs_to :request

  before_save :update_gcal

  def serialize
	{
		  'summary' => request.summary,
		  'start' => {
		    'dateTime' => request.time
		  },
	}
  end

  def update_gcal
  	#TODO make this handle errors in updating to the api
  	if self.request and self.request.approved
	  	client = request.calendar.client
	  	gcal = request.calendar.gcalendar

	  	event = serialize

	  	if google_cal_id != nil
		  	res = client.execute(:api_method => gcal.events.update,
		  				   :parameters => {'calendarId' => request.calendar.key, 'eventId' => self.google_cal_id},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
	  	else
		  	res = client.execute(:api_method => gcal.events.insert,
		  				   :parameters => {'calendarId' => request.calendar.email},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
	  	end
	  	# puts res.status
	  	parsed = JSON.parse(res.body)
	  	self.google_cal_id = parsed["id"]
	end
  end
end
