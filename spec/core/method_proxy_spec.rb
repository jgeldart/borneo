require File.dirname(__FILE__) + "/../spec_helper.rb"

describe Borneo::MethodProxy do

  let(:client_id) { "SOME_CLIENT_ID" }
  let(:client_secret) { "SOME_CLIENT_SECRET" }
  let(:redirect_url) { "http://localhost" }
  let(:client) { Borneo::Client.new(client_id, client_secret, redirect_url) }
  let(:access_token) { "ACCESS_TOKEN" }
  let(:refresh_token) { "REFRESH_TOKEN" }
  let(:proxy) { Borneo::AuthorizedProxy.new(client, access_token, refresh_token) }
  let(:service_name) { "oauth2" }
  let(:service_version) { "v2" }
  let(:service) { Borneo::Service.new(proxy, service_name, service_version) }

  let(:method_name) { :userinfo }

  describe "initializer" do

    it "should take a service and name as parameters" do
      method_proxy = Borneo::MethodProxy.new(service, method_name)
      method_proxy._service.should == service
      method_proxy._components.should == [method_name]
    end

    it "should take a service, name and previous components as parameters" do
      method_proxy = Borneo::MethodProxy.new(service, :get, [:userinfo])
      method_proxy._service.should == service
      method_proxy._components.should == [:userinfo, :get]
    end
  end

  describe "extension" do
    let(:method_proxy) { Borneo::MethodProxy.new(service, method_name) }

    it "should return a new proxy"  do
      method_proxy.get.should be_a(Borneo::MethodProxy)
    end

    it "should extend the previous one's components by the new name" do
      method_proxy.get._components.should == [:userinfo, :get]
    end

    it "should have the right service" do
      method_proxy.get._service.should == service
    end

  end

  describe "calling" do
    let(:method_proxy) { Borneo::MethodProxy.new(service, :get, [:userinfo]) }

    before do
      stub_request(:get, "https://www.googleapis.com/discovery/v1/apis/oauth2/v2/rest")
         .to_return(lambda {|request| File.new(File.dirname(__FILE__) + "/../discovery_document.json")})

      stub_request(:get, "https://www.googleapis.com/oauth2/v2/userinfo").to_return(
        :status => 200,
        :headers => { 'Content-Type' => 'application/json' },
        :body => <<-RESP
{
 "id": "0000",
 "email": "jsmith@example.com",
 "verified_email": true,
 "name": "John Smith",
 "given_name": "John",
 "family_name": "Smith",
 "link": "https://plus.google.com/0000",
 "gender": "male",
 "birthday": "0000-01-01",
 "locale": "en",
 "hd": "example.com"
}
        RESP
      )
    end

    it "should be callable with 0 arguments" do
      method_proxy.should respond_to(:call).with(0).arguments
    end

    it "should return" do
      profile = method_proxy.call
      profile.name.should == "John Smith"
    end
  end

  describe "uploading" do
    let(:drive_service) { Borneo::Service.new(proxy, "drive", "v2") }
    let(:method_proxy) { Borneo::MethodProxy.new(drive_service, :insert, [:files]) }
    let(:title) { "My Title" }
    before do
      stub_request(:get, "https://www.googleapis.com/discovery/v1/apis/drive/v2/rest")
         .to_return(lambda {|request| File.new(File.dirname(__FILE__) + "/../drive_discovery_document.json")})

      stub_request(:post, "https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart")
         .to_return( 
            :status => 200,
            :headers => { 'Content-Type' => 'application/json' },
            :body => <<-RESP
{
 "kind": "drive#file",
 "id": "1FIBM-hRZlKNrAAYAQjfM3XpnmZ_KLT6D_NWzhojKKPg",
 "etag": "HK9znrxLd1pIgz63yXyznaLN5rM/MTM3NjAxMjQ0OTU0MQ",
 "title": "#{title}",
 "mimeType": "application/vnd.google-apps.document",
 "labels": {
  "starred": false,
  "hidden": false,
  "trashed": false,
  "restricted": false,
  "viewed": true
 },
 "createdDate": "2013-08-09T01:28:03.900Z",
 "modifiedDate": "2013-08-09T01:40:49.541Z",
 "modifiedByMeDate": "2013-08-09T01:40:49.541Z",
 "lastViewedByMeDate": "2013-08-09T01:40:49.541Z"
}
            RESP
                   )
    end
    it "should be callable with 2 arguments" do
      method_proxy.should respond_to(:upload_file).with(2).arguments
    end
    it "should return" do
      file = method_proxy.upload_file(File.dirname(__FILE__) + "/../example.html", "text/html", :title => title)
      file.title.should == title
    end
  end
end
