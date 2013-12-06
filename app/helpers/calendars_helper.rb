module CalendarsHelper
	def events_to_csv events
		CSV.generate do |csv|
			csv << ["Event", "Starting", "Ending", "Number of Attendees"] # add column names first

			events.each do |e|
				csv << [e.summary, e.start.nil? ? "" : e.start.date_time.to_s, e.end.nil? ? "" : e.end.date_time.to_s, e.attendees.size] 
			end
		end
	end

	def calendars_to_csv calendars
		CSV.generate do |csv|
			csv << ["Name", "Email", "Visibility", "Fee required", "Disabled", "Building", "Usage"]

			calendars.each do |cal|
				csv << [cal.name, cal.email, cal.visibility, cal.fee_required, cal.disabled, cal.building, cal.usage]
			end
		end
	end

end
