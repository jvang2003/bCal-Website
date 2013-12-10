class Event < ActiveRecord::Base
  belongs_to :request
  before_save :update_gcal

  def serialize
	{
		  'summary' => request.reason,
		  'start' => {
		    "dateTime" => convert_to_google_time_format(request.start_time)
                    #"dateTime" => "2013-11-29T18:30:00z"
		  },
                  "end" => {
                    "dateTime" => convert_to_google_time_format(request.finish_time)
                    #"dateTime" => "2013-11-29T19:30:00z"
                  },
                  "attendees" => create_attendees(request.people)
	}
  end

  def convert_to_google_time_format(datetime)
     split_datetime = datetime.time.to_s.split(" ")
     result_time = split_datetime[1] + "z"
     print(split_datetime[0] + "T" + result_time)
     return split_datetime[0] + "T" + result_time
  end
  def update_gcal
  	#TODO make this handle errors in updating to the api
  	if self.request and self.request.status == "Approved"
	  	client = request.place.client
	  	gcal = request.place.gcalendar

	  	event = serialize

	  	if google_cal_id != nil
		  	res = client.execute(:api_method => gcal.events.update,
		  				   :parameters => {'calendarId' => request.place.email, 'eventId' => self.google_cal_id},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
	  	else
		  	res = client.execute(:api_method => gcal.events.insert,
		  				   :parameters => {'calendarId' => request.place.email},
				  		   :body => JSON.dump(event),
	                       :headers => {'Content-Type' => 'application/json'})
	  	end

	  	parsed = JSON.parse(res.body)
	  	self.google_cal_id = parsed["id"]
  	end
  end

  def delete_event
      res = request.calendar.client.execute(:api_method => request.calendar.gcalendar.events.delete,
        :parameters => {:calendarId => request.calendar.email, :eventId => self.google_cal_id})
  end

  def create_attendees(size)
      result = []
      i = 0
      while (size != nil and i < size)
          result.push({:email => i.to_s + "@gmail.com"})
          i = i + 1
      end
      return result
  end
end
