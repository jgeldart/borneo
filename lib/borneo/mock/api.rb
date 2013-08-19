module Borneo::Mock::API

  extend self

  def stub_service(name, version)
    Borneo::Client.stub_service(name, version)
  end

end
