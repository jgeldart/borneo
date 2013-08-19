class Borneo::Mock::Service

  attr :client, :name, :version

  def initialize(client, name, version)
    @client = client
    @name = name
    @version = version
    @methods = {}
    @response_data = nil
  end

  def to_return(result)
    @response_data = result
  end

  def mock_response(components)
    if components.count == 0
      @response_data
    else
      next_proxy = @methods[components[0]]
      unless next_proxy.nil?
        next_proxy.mock_response(components.drop(1))
      else
        raise "Request not stubbed for #{components}"
      end
    end
  end

  def method_missing(method_name)
    @methods[method_name] ||= Borneo::Mock::Service.new(@client, @name, @version)
  end

end
