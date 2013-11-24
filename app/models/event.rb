class Event < ActiveRecord::Base
  belongs_to :request

  before_save :update_gcal

  def serialize
	{
		  'summary' => request.reason,
		  'start' => {
		    "dateTime" => convert_to_google_time_format(request.time)
                    #"dateTime" => "2013-11-29T18:30:00"
		  },
                  "end" => {
                    "dateTime" => convert_to_google_time_format(request.time)
                    #"dateTime" => "2013-11-29T18:30:00"
                  }
                  #"attendees" => [
                  #  {
                  #      'email' => 'abc@gmail.com'
                  #  }
                  #]
	}
  end

  def convert_to_google_time_format(datetime)
     split_time = datetime.time.to_s.split(" ")
     return split_time[0] + "T" + split_time[1] + "z"
  end
  def update_gcal
  	#TODO make this handle errors in updating to the api
  	if self.request and self.request.status == "approved"
	  	client = request.calendar.client
	  	gcal = request.calendar.gcalendar

	  	event = serialize

	  	if google_cal_id != nil
		  	res = client.execute(:api_method => gcal.events.update,
		  				   :parameters => {'calendarId' => request.calendar.email, 'eventId' => self.google_cal_id},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
	  	else
		  	res = client.execute(:api_method => gcal.events.insert,
		  				   :parameters => {'calendarId' => request.calendar.email},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
	  	end
	  	#puts res.data
	  	parsed = JSON.parse(res.body)
	  	self.google_cal_id = parsed["id"]
	end
  end
  def delete_event
      client = request.calendar.client
      gcal = request.calendar.gcalendar
      res = client.execute(:api_method => gcal.events.delete, :parameters => {:calendarId => request.calendar.email, :eventId => self.google_cal_id})
  end
end
