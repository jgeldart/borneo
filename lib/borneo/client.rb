require 'google/api_client'

class Borneo::Client

  attr_reader :client_id, :client_secret, :redirect_url

  def initialize(client_id, client_secret, redirect_url)
    @client_id = client_id
    @client_secret = client_secret
    @redirect_url = redirect_url
  end

  def for(access_token, refresh_token)
    Borneo::AuthorizedProxy.new(self,access_token, refresh_token)
  end

  def google_client
    Google::APIClient.new
  end

end
