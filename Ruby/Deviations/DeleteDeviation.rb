require 'net/http'
require 'uri'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
deviation_id = "YOUR DEVIATION ID"

uri = URI.parse("#{boards_on_fire_api_url}/deviations/#{deviation_id}")
request = Net::HTTP::Delete.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  puts "Deviation deleted successfully."
else
  puts "Request error: #{response.message}"
end
