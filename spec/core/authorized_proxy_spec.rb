require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Borneo::AuthorizedProxy do

  let(:client_id) { "SOME_CLIENT_ID" }
  let(:client_secret) { "SOME_CLIENT_SECRET" }
  let(:redirect_url) { "http://localhost" }
  let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }
  let(:access_token) { "ACCESS_TOKEN" }
  let(:refresh_token) { "REFRESH_TOKEN" }

  describe "initializer" do
    it "should take client, access_token and refresh token parameters" do
      proxy = Borneo::AuthorizedProxy.new(client, access_token, refresh_token)
      proxy.client.should == client
      proxy.access_token.should == access_token
      proxy.refresh_token.should == refresh_token
    end
  end

  describe "service creator" do
    let(:proxy) { Borneo::AuthorizedProxy.new(client, access_token, refresh_token) }

    it "should take two parameters" do
      proxy.should respond_to(:service).with(2).arguments
    end

    let(:service_name) { "oauth2" }
    let(:service_version) { "v2" }

    it "should return a service object" do
      proxy.service(service_name, service_version).should be_a(Borneo::Service)
    end

    describe "returned service" do
      let(:service) { proxy.service(service_name, service_version) }

      it "should use the creating authorised proxy" do
        service.proxy.should == proxy
      end

      it "should have the right name" do
        service.name.should == service_name
      end

      it "should have the right version" do
        service.version.should == service_version
      end
    end
  end

end
