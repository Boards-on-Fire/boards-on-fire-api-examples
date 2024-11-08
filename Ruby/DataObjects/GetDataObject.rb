require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
data_source_name = "YOUR DATA SOURCE NAME"
data_object_id = "YOUR DATA OBJECT ID"

uri = URI.parse("#{boards_on_fire_api_url}/datasources/#{data_source_name}/dataobjects/#{data_object_id}")
request = Net::HTTP::Get.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "DataObject:"
  puts data
else
  puts "Request error: #{response.message}"
end
