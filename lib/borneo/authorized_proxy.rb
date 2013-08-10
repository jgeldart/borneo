class Borneo::AuthorizedProxy

  attr_reader :client, :access_token, :refresh_token

  def initialize(client, access_token, refresh_token)
    @client = client
    @access_token = access_token
    @refresh_token = refresh_token
  end

end
