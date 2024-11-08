require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
user_id = "YOUR USER ID"

uri = URI.parse("#{boards_on_fire_api_url}/users/#{user_id}")
request = Net::HTTP::Get.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "User:"
  puts data
else
  puts "Request error: #{response.message}"
end
