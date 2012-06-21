# Example ruby code to get a token from the NeCTAR cloud

# Requires JSON library
# gem install json

require 'net/http'
require 'json'
require './credentials' # You will need to create this file. See README.

class TokenRequest

  # Method for generating JSON for token request
  def self.to_json(user, password, tenant_name)
    JSON.generate (
      {
      'auth' => {
        'tenantName' => tenant_name,
        'passwordCredentials' =>
        {
          'username' => user,
          'password' => password
        }
      }
    })
  end

  # Call this to get your auth token
  def self.get_token(user, password, tenant_name)

    url = URI('http://keystone.rc.nectar.org.au:5000/v2.0/tokens')

    # make a connection
    token_id = Net::HTTP.start(url.host, url.port) do |http|
      request = Net::HTTP::Post.new url.path
    
      # set the content type
      request.content_type = 'application/json'
    
      # set the body of the request
      request.body = TokenRequest.to_json user, password, tenant_name
      
      raw_response = http.request request
      json_response = JSON.parse raw_response.body
   
      # Print the json response
      #print JSON.pretty_generate(json_response)

      token_id = json_response['access']['token']['id']
      #api_url = json_response['access']['serviceCatalog'][2]['endpoints'][0]['publicURL']
      token_id
    end
    token_id
  end
end

# Example usage
print TokenRequest.get_token($USER, $PASSWORD, $TENANT_NAME) + "\n"
