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

end
