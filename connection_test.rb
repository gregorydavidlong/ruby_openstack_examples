# Example ruby code to test a connection to the NeCTAR cloud

require 'net/http'
require './credentials'

URL = URI('http://keystone.rc.nectar.org.au:35357/v2.0')

Net::HTTP.start(URL.host, URL.port) do |http|
  request = Net::HTTP::Get.new URL.request_uri

  # Set the headers
  request['X-Auth-Key'] = $PASSWORD
  request['X-Auth-User'] = $USER

  #make the request
  response = http.request request

  #print the response
  print response.body

end
