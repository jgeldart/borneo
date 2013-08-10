class Borneo::Service

  attr :proxy, :name, :version

  def initialize(proxy, name, version)
    @proxy = proxy
    @name = name
    @version = version
  end

end
