require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Borneo::Service do

  let(:client_id) { "SOME_CLIENT_ID" }
  let(:client_secret) { "SOME_CLIENT_SECRET" }
  let(:redirect_url) { "http://localhost" }
  let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }
  let(:access_token) { "ACCESS_TOKEN" }
  let(:refresh_token) { "REFRESH_TOKEN" }
  let(:proxy) { Borneo::AuthorizedProxy.new(client, access_token, refresh_token) }
  let(:service_name) { "oauth2" }
  let(:service_version) { "v2" }

  describe "initializer" do

    it "should take proxy, service name and service version as parameters" do
      service = Borneo::Service.new(proxy, service_name, service_version)
      service.proxy.should == proxy
      service.name.should == service_name
      service.version.should == service_version
    end

  end
end
