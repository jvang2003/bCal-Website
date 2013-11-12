require 'google/api_client'

module CalendarHelper
	def CalendarHelper::calendar
		@calendar
	end

	def CalendarHelper::check_auth redirect_uri
		if @client == nil
			return CalendarHelper::init redirect_uri
		end
		return nil
	end
end
