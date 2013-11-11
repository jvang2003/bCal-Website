require 'google/api_client'

class Calendar < ActiveRecord::Base
  has_many :request
  
  attr_accessible :name, :key, :visib, :fee_required, :disabled
  attr_accessor :gcalendar, :client
  after_initialize :init
  after_find :init

  def init
    @client = Google::APIClient.new :application_name => "bCal Integration", :application_version => 1
    @gcalendar = @client.discovered_api 'calendar', 'v3'

    if self.access_token and self.refresh_token
	  update_tokens! :refresh_token => @refresh_token, :access_token => @access_token
    end

    @client.authorization.client_id = '1048722423867.apps.googleusercontent.com'
    @client.authorization.client_secret = 'DgAjHWfmn-toHyUObGhecF-m'
    @client.authorization.redirect_uri = 'http://localhost:3000/oauth_redirect'
    
    @client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
  end

  def update_tokens! options
  	@client.authorization.update! options

    @access_token = @client.authorization.access_token
    @refresh_token = @client.authorization.refresh_token
  end

  def oauth_redirect code
    @client.authorization.code = @key = code
    @client.authorization.fetch_access_token!

    @access_token = @client.authorization.access_token
    @refresh_token = @client.authorization.refresh_token
  end
end