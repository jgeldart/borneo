class Borneo::Client

  attr_reader :client_id, :client_secret, :redirect_url

  def initialize(client_id, client_secret, redirect_url)
    @client_id = client_id
    @client_secret = client_secret
    @redirect_url = redirect_url
  end

end
