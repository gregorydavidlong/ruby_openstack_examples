#Not yet working on NeCTAR
require './get_token'
require 'net/http'
require './credentials' # You will need to create this file. See README.

#url = URI('http://nova.rc.nectar.org.au:8773/services/Cloud/48/images')
#url = URI('http://keystone.rc.nectar.org.au:5000/v2.0/' + $TENANT_ID + '/images')
url = URI('http://nova.rc.nectar.org.au:8774/v1.1/' + $TENANT_ID + '/images')
#url = URI('http://np-rcp1.melbourne.nectar.org.au:9292/v1/images')

Net::HTTP.start(url.host, url.port) do |http|
  request = Net::HTTP::Get.new url.request_uri

  # Set the headers
  request['X-Auth-Token'] = TokenRequest.get_token($USER, $PASSWORD, $TENANT_ID)
  request['X-Auth-Project-Id'] = 'pt-49'
  request.content_type = 'application/json'
  request['Accept'] = 'application/xml'

  #make the request
  response = http.request request

  #print the response
  print response.body

end
