require 'google/api_client'

class Borneo::Client

  attr_reader :client_id, :client_secret, :redirect_url, :application_name, :application_version

  def initialize(client_id, client_secret, redirect_url, application_name = "Borneo Application", application_version = "0.0.1")
    @client_id = client_id
    @client_secret = client_secret
    @redirect_url = redirect_url
    @google_client = nil
    @application_name = application_name
    @application_version = application_version
  end

  def for(access_token, refresh_token)
    google_client.authorization.clear_credentials!
    Borneo::AuthorizedProxy.new(self,access_token, refresh_token)
  end

  def google_client
    @google_client ||= Google::APIClient.new(:application_name => @application_name, :application_version => @application_version)
  end

end
