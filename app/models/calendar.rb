require 'google/api_client'

class Calendar < ActiveRecord::Base
  has_many :request
  
  attr_accessible :name, :email, :visib, :fee_required, 
    :disabled, :refresh_token, :access_token, :building, :dept, :usage
  attr_accessor :gcalendar, :client   
  after_initialize :init
  after_find :init

  def init
  	if @client == nil and @gcalendar == nil
	    @client = Google::APIClient.new :application_name => "bCal Integration", :application_version => 1, :authorization => :oauth_2
	    @gcalendar = @client.discovered_api 'calendar', 'v3'

	    @client.authorization.client_id = '1048722423867.apps.googleusercontent.com'
	    @client.authorization.client_secret = 'DgAjHWfmn-toHyUObGhecF-m'
	    @client.authorization.redirect_uri = Rails.env.production? ? 'http://b-cal.herokuapp.com/oauth_redirect': 'http://localhost:3000/oauth_redirect'
	    
	    @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'

	    if refresh_token and access_token
		    update_tokens! :refresh_token => refresh_token, :access_token => access_token
	    end
	  end
  end

  def update_tokens! options
  	@client.authorization.update_token! :access_token => options[:access_token], :refresh_token => options[:refresh_token]

  	self.access_token = options[:access_token]
  	self.refresh_token = options[:refresh_token]
  end

  def oauth_redirect code
    @client.authorization.code = @key = code
    @client.authorization.fetch_access_token!

  	self.access_token = @client.authorization.access_token
  	self.refresh_token = @client.authorization.refresh_token
  end
end