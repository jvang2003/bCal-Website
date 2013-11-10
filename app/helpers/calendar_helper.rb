require 'google/api_client'

module CalendarHelper
	def CalendarHelper::client
		@client
	end

	def CalendarHelper::calendar
		@calendar
	end

	def CalendarHelper::check_auth redirect_uri
		if @client == nil
			return CalendarHelper::init redirect_uri
		end
		return nil
	end

	def CalendarHelper::handle_code code
		@client.authorization.code = code
		@client.authorization.fetch_access_token!
	end

	private
	def CalendarHelper::init redirect_uri
	    @client = Google::APIClient.new :application_name => "bCal Integration", :application_version => 1
	    @calendar = @client.discovered_api 'calendar', 'v3'

	    # Initialize OAuth 2.0 client    
	    @client.authorization.client_id = '1048722423867.apps.googleusercontent.com'
	    @client.authorization.client_secret = 'DgAjHWfmn-toHyUObGhecF-m'
	    @client.authorization.redirect_uri = redirect_uri
	    
	    @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'

	    # Request authorization
	    return @client.authorization.authorization_uri
	end
end
