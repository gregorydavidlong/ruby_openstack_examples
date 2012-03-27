#Not yet working with the NeCTAR cloud
require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

#url = URI('http://nova.rc.nectar.org.au:8774/v1.1/' + $TENANT_ID + '/servers')
url = URI('http://keystone.rc.nectar.org.au:5000/v2.0/' + $TENANT_ID + '/servers')

class ServerCreate
  def self.to_json(server_name, image_id, flavour_id)
    JSON.generate (
    {
      'server' => 
      {
        'name' => server_name,
        'imageId' => image_id,
        'flavorId' => flavour_id
        #'metadata' => ...
        #'personality' => ...
      }
    })
  end
end



Net::HTTP.start(url.host, url.port) do |http|
      request = Net::HTTP::Post.new url.path

      image_id = '22901'
      flavor_id = '0'
    
      # set the content type
      request.content_type = 'application/json'
      request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_ID)
      request['X-Auth-Project-Id'] = 'pt-49'

      # set the body of the request
      request.body = ServerCreate.to_json "Server Name", image_id, flavor_id
      print request.body
      
      raw_response = http.request request
      json_response = JSON.parse raw_response.body
   
      print raw_response.body

    end
