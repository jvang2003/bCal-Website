require 'google/api_client'

module RequestHelper
	@client = nil

	def RequestHelper::gcal_client
		if @client == nil
			RequestHelper::init
		end
		@client
	end

	def RequestHelper::g_calendar
		@calendar
	end

	def check_auth
		if @client == nil
			return RequestHelper::init
		end
		return nil
	end

	private
	def RequestHelper::init
		# Initialize the client & Google+ API
	    @client = Google::APIClient.new :application_name => "bCal Integration", :application_version => 1
	    @calendar = @client.discovered_api 'calendar', 'v3'

	    # Initialize OAuth 2.0 client    
	    @client.authorization.client_id = '1048722423867.apps.googleusercontent.com'
	    @client.authorization.client_secret = 'DgAjHWfmn-toHyUObGhecF-m'
	    @client.authorization.redirect_uri = 'http://www.google.com'
	    
	    @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'

	    # Request authorization
	    return @client.authorization.authorization_uri
	end
end
