require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

server_id = '2178'
url = URI('http://nova.rc.nectar.org.au:8774/v1.1/' + $TENANT_ID + '/servers/' + server_id)

Net::HTTP.start(url.host, url.port) do |http|
  request = Net::HTTP::Get.new url.request_uri

  # Set the headers
  request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_ID)
  request.content_type = 'application/json'

  #make the request
  response = http.request request

  #print the response
  print response.body

end
