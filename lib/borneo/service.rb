class Borneo::Service

  attr :proxy, :name, :version

  def initialize(proxy, name, version)
    @proxy = proxy
    @name = name
    @version = version
  end

  def _client
    @proxy.google_client
  end

  def _authorization
    @proxy.authorization
  end

  def _discovered_service
    _client.discovered_api(@name, @version)
  end

  def method_missing(name)
    Borneo::MethodProxy.new(self, name)
  end

end
