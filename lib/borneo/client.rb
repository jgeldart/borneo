require 'google/api_client'

class Borneo::Client

  @@should_mock_requests = false

  attr_reader :client_id, :client_secret, :redirect_url, :application_name, :application_version

  def self.enable_mocking!
    @@should_mock_requests = true
    @@service_stubs = {}
  end

  def self.disable_mocking!
    @@should_mock_requests = false
  end

  def self.reset_mocks!
    @@service_stubs = {}
  end

  def self.stub_service(service_name, service_version)
    @@service_stubs[[service_name, service_version]] ||= Borneo::Mock::Service.new(self, service_name, service_version)
  end

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

  def mocking_requests?
    !!@@should_mock_requests
  end

end
