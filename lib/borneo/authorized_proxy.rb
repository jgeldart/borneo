require 'signet/oauth_2/client'

class Borneo::AuthorizedProxy

  attr_reader :client, :access_token, :refresh_token

  def initialize(client, access_token, refresh_token)
    @client = client
    @access_token = access_token
    @refresh_token = refresh_token
  end

  def service(name, version)
    Borneo::Service.new(self, name, version)
  end

  def authorization
    new_authorization = Signet::OAuth2::Client.new
    new_authorization.client_id = @client.client_id
    new_authorization.client_secret = @client.client_secret
    new_authorization.authorization_uri = "https://accounts.google.com/o/oauth2/auth"
    new_authorization.token_credential_uri = "https://accounts.google.com/o/oauth2/token"
    new_authorization.redirect_uri = @client.redirect_url

    new_authorization.update_token!(
      :access_token => @access_token,
      :refresh_token => @refresh_token
    )

    new_authorization
  end

  def google_client
    @client.google_client
  end

end
