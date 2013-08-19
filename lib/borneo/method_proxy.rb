module Borneo::ResponseStatus
  STALE_ACCESS_TOKEN = 401
end

class Borneo::MethodProxy

  attr :_service, :_components

  def initialize(service, name, components=[])
    @_service = service
    @_components = components.clone
    @_components << name
  end

  def mocking_enabled?
    @_service.proxy.client.mocking_requests?
  end

  def call(params = {})
    unless mocking_enabled?
      method_call = lambda do
        _client.execute(
          :api_method => _method,
          :authorization => _authorization,
          :parameters => params
        )
      end
      response = method_call.call()
      if response.status == Borneo::ResponseStatus::STALE_ACCESS_TOKEN
        _client.authorization.fetch_access_token!
        response = method_call.call()
      end

      data = response.data
    else
      data = mock_service.mock_response(@_components)
    end

    data

  end

  def _client
    @_service._client
  end

  def _authorization
    @_service._authorization
  end

  def _method
    m = @_service._discovered_service
    @_components.each do |c|
      m = m.send(c)
    end
    m
  end

  def mock_service
    Borneo::Client.stub_service(@_service.name, @_service.version)
  end

  def method_missing(name)
    Borneo::MethodProxy.new(@_service, name, @_components)
  end

end
