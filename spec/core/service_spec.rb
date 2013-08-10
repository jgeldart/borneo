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

    describe "method proxy" do

      let(:service) { Borneo::Service.new(proxy, service_name, service_version) }

      it "should be returned for anything else" do
        service.userinfo.should be_a(Borneo::MethodProxy)
      end

      it "should have the right components" do
        service.userinfo._components.should == [:userinfo]
      end

      it "should have the right service" do
        service.userinfo._service.should == service
      end

    end

    describe "utility methods" do
      let(:service) { Borneo::Service.new(proxy, service_name, service_version) }

      describe "discovered service" do
        it "should be callable" do
          service.should respond_to(:_discovered_service)
        end
      end
      describe "authorization" do
        it "should be callable" do
          service.should respond_to(:_authorization)
        end
      end
      describe "client" do
        it "should be callable" do
          service.should respond_to(:_client)
        end
      end


    end


  end
end
