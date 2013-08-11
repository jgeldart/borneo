require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Borneo::Client do

  let(:client_id) { "SOME_CLIENT_ID" }
  let(:client_secret) { "SOME_CLIENT_SECRET" }
  let(:redirect_url) { "http://localhost" }

  describe "initialiser" do
    it "takes a client ID, client secret and redirect URL parameters" do
      client = Borneo::Client.new(client_id, client_secret, redirect_url)
      client.client_id.should == client_id
      client.client_secret.should == client_secret
      client.redirect_url.should == redirect_url
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

end
