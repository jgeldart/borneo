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

end
