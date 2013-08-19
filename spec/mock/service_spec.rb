require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Borneo::Mock::Service do

  let(:client_id) { "SOME_CLIENT_ID" }
  let(:client_secret) { "SOME_CLIENT_SECRET" }
  let(:redirect_url) { "http://localhost" }
  let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }
  let(:service_name) { "oauth2" }
  let(:service_version) { "v2" }

  describe "initializer" do
    it "should take the client, service name and service version as parameters" do
      service = Borneo::Mock::Service.new(client, service_name, service_version)
      service.client.should == client
      service.name.should == service_name
      service.version.should == service_version
    end
  end

  describe "stubbed responses" do
    let(:client_id) { "SOME_CLIENT_ID" }
    let(:client_secret) { "SOME_CLIENT_SECRET" }
    let(:redirect_url) { "http://localhost" }
    let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }
    let(:access_token) { "ACCESS_TOKEN" }
    let(:refresh_token) { "REFRESH_TOKEN" }
    let(:service_name) { "oauth2" }
    let(:service_version) { "v2" }
    let(:service) { Borneo::Mock::Service.new(client, service_name, service_version) }
    let(:stubbed_response) { { :id => "0000", :email => "jsmith@example.com" } }

    it "allows simple responses to be stubbed" do
      service.userinfo.should respond_to(:to_return)
    end

    it "returns stubbed response when query is made" do
      Borneo::Client.enable_mocking!
      Borneo::Client.stub_service(service_name, service_version).userinfo.to_return stubbed_response
      client.for(access_token, refresh_token).service(service_name, service_version).userinfo.call.should == stubbed_response
    end

    it "raises an error when mocks aren't defined" do
      Borneo::Client.enable_mocking!
      lambda { client.for(access_token, refresh_token).service(service_name, service_version).userinfo.call }.should raise_exception(RuntimeError)
    end

    it "raises an error when mocks are reset" do
      Borneo::Client.enable_mocking!
      Borneo::Client.stub_service(service_name, service_version).userinfo.to_return stubbed_response
      Borneo::Client.reset_mocks!
      lambda { client.for(access_token, refresh_token).service(service_name, service_version).userinfo.call }.should raise_exception(RuntimeError)
    end
  end
 
  describe "methods" do
    let(:service) { Borneo::Mock::Service.new(client, service_name, service_version) }

    it "should return another mock service for anything else" do
      service.userinfo.should be_a(Borneo::Mock::Service)
    end

  end
end
