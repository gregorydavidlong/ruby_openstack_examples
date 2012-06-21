require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.
require 'json'

url = URI('http://swift.rc.nectar.org.au:8888/v1.0/AUTH_' + $TENANT_ID)


Net::HTTP.start(url.host, url.port) do |http|
  request = Net::HTTP::Get.new url.request_uri

  # Set the headers
  request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_NAME)
  request.content_type = 'application/json'

  #make the request
  response = http.request request

  #print the response
  print response.body

end
