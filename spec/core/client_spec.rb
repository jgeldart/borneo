require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Borneo::Client do

  let(:client_id) { "SOME_CLIENT_ID" }
  let(:client_secret) { "SOME_CLIENT_SECRET" }
  let(:redirect_url) { "http://localhost" }
  let(:app_name) { "SomeApplication" }
  let(:app_version) { "1.0.1" }

  describe "initialiser" do
    it "takes a client ID, client secret and redirect URL parameters" do
      client = Borneo::Client.new(client_id, client_secret, redirect_url)
      client.client_id.should == client_id
      client.client_secret.should == client_secret
      client.redirect_url.should == redirect_url
    end

    it "optionally takes an application name and version" do
      client = Borneo::Client.new(client_id, client_secret, redirect_url, app_name, app_version)
      client.application_name.should == app_name
      client.application_version.should == app_version
    end
  end

  it "should cache the Google client value" do
    client = Borneo::Client.new(client_id, client_secret, redirect_url)
    client.google_client.should == client.google_client
  end

  describe "for" do

    let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }
    let(:access_token) { "ACCESS_TOKEN" }
    let(:refresh_token) { "REFRESH_TOKEN" }

    let(:proxy) { client.for(access_token, refresh_token) }

    it "should return an authorized proxy" do
      proxy.should be_a(Borneo::AuthorizedProxy)
    end

    describe "returned proxy" do
      it "should have the creating client as its client" do
        proxy.client.should == client
      end

      it "should contain the access token" do
        proxy.access_token.should == access_token
      end

      it "should contain the refresh token" do
        proxy.refresh_token.should == refresh_token
      end
    end

  end

  describe "mocking" do
    let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }

    it "defaults to not mocking" do
      client.should_not be_mocking_requests
    end

    it "can be set globally to use a mock rather than calling external services" do
      Borneo::Client.enable_mocking!
      client.should be_mocking_requests
    end

    it "can be set globally to disable mocking" do
      Borneo::Client.enable_mocking!
      client.should be_mocking_requests
      Borneo::Client.disable_mocking!
      client.should_not be_mocking_requests
    end

    describe "stub_service" do
      it "should return a mock service" do
        Borneo::Client.stub_service('plus', 'v1').should be_a(Borneo::Mock::Service)
      end
    end

  end


end
