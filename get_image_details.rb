require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

image_id = '22ec6722-fe12-4eae-b3cc-fd610e3770b5'
url = URI('http://nova.rc.nectar.org.au:8774/v1.1/' + $TENANT_ID + '/images/' + image_id)

Net::HTTP.start(url.host, url.port) do |http|
  request = Net::HTTP::Get.new url.request_uri

  # Set the headers
  request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_NAME)
  request.content_type = 'application/json'

  #make the request
  response = http.request request

  #print the response
  print JSON.pretty_generate(JSON.parse(response.body))

end
