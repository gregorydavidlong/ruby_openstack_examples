# Example ruby code to get a token from the NeCTAR cloud

# Requires JSON library
# gem install json

require 'net/http'
require 'json'
require './credentials'

URL = URI('http://keystone.rc.nectar.org.au:35357/v2.0/tokens')

# Class for generating JSON
class TokenRequest
  def self.to_json(user, password, tenant_id)
    JSON.generate (
      {
      'auth' => {
        'passwordCredentials' =>
        {
          'username' => user,
          'password' => password
        },
        'tenantId' => tenant_id
      }
    })
  end
end


# Try using JSON
Net::HTTP.start(URL.host, URL.port) do |http|
  request = Net::HTTP::Post.new URL.path

  # set the content type
  request.content_type = 'application/json'

  # set the body of the request
  request.body = TokenRequest.to_json $USER, $PASSWORD, $TENANT_ID
  
  response = http.request request
  print response.body
end
