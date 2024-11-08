require 'net/http'
require 'uri'
require 'json'
require 'securerandom'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
data_source_name = "YOUR DATA SOURCE NAME"
organization_id = "YOUR ORGANIZATION ID"

uri = URI.parse("#{boards_on_fire_api_url}/datasources/#{data_source_name}/dataobjects")
request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

# Data Source with numeric fields goal and outcome
request_body = {
  goal: 50,
  outcome: 40,
  timestamp: "2024-11-08T10:30:00Z",
  group_name: "default",
  comment: "Sample comment",
  data_annotations: {
    outcome: {
      comment: "Outcome comment",
      color: "blue"
    }
  },
  organization_id: organization_id
}

request.body = request_body.to_json

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
