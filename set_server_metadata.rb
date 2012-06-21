# Set server metadata
require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

server_id = '2620'

url = URI('http://nova.rc.nectar.org.au:8774/v1.1/' + $TENANT_ID + '/servers/' + server_id + '/metadata')


class ServerSetMetadata
  def self.to_json(key, value)
    JSON.generate (
    {
      'metadata' => 
      {
        key => value
      }
    })
  end
end



Net::HTTP.start(url.host, url.port) do |http|
      request = Net::HTTP::Put.new url.path
    
      # set the content type
      request.content_type = 'application/json'
      request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_NAME)
      request['Accept'] = 'application/json'
    
      # set the body of the request
      request.body = ServerSetMetadata.to_json "a metadata key", "a metadata value"
      
      raw_response = http.request request
   
      print raw_response.body

    end
