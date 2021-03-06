require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

url = URI('http://keystone.rc.nectar.org.au:35357/v2.0/extensions');

Net::HTTP.start(url.host, url.port) do |http|
  request = Net::HTTP::Get.new url.request_uri

  # Set the headers
  request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_NAME)
  request.content_type = 'application/json'
  request['Accept'] = 'application/xml'

  #make the request
  response = http.request request

  #print the response
  print response.body

end
