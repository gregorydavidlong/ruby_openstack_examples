# Example ruby code to get a token from the NeCTAR cloud

# Requires JSON library
# gem install json

require 'net/http'
require 'json'
require './credentials' # You will need to create this file. See README.

URL = URI('http://keystone.rc.nectar.org.au:35357/v2.0/tokens')


class TokenRequest

  # Method for generating JSON for token request
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

  # Call this to get your auth token
  def self.get_token(user, password, tenant_id)

    # make a connection
    token_id = Net::HTTP.start(URL.host, URL.port) do |http|
      request = Net::HTTP::Post.new URL.path
    
      # set the content type
      request.content_type = 'application/json'
    
      # set the body of the request
      request.body = TokenRequest.to_json user, password, tenant_id
      
      raw_response = http.request request
      json_response = JSON.parse raw_response.body
    
      token_id = json_response['access']['token']['id']
      token_id
    end
    token_id
  end
end

# Example usage
print TokenRequest.get_token($USER, $PASSWORD, $TENANT_ID) + "\n"
