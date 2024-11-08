require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
organization_id = "YOUR ORGANIZATION ID"

uri = URI.parse("#{boards_on_fire_api_url}/deviations")
request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

request_body = {
  date: "2024-11-08",
  deviation_category: "514bec1f-c835-4dca-8379-ea17b7014757",  # Deviation Category Id
  deviation_type: "3894c7bc-5113-4e51-be20-985ec10cbadf",  # Deviation Type Id
  discard: false,
  name: "Stop in production",
  organization_id: organization_id,
  responsible: "081b3310-4980-4c3f-a7c1-9bce5d315be3",  # User id
  risk_consequence: 1.0,
  risk_probability: 3.0,
  source: "Deviation System",
  status: 20
}

request.body = request_body.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "Deviation:"
  puts data
else
  puts "Request error: #{response.message}"
end
