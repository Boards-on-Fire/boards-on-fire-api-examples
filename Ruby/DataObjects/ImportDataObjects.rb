require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
data_source_name = "YOUR DATA SOURCE NAME"

uri = URI.parse("#{boards_on_fire_api_url}/datasources/#{data_source_name}/dataobjects/import")
request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

# Data Source with numeric fields goal and outcome
request_body = [
  {
    goal: 50,
    outcome: 40,
    timestamp: "2024-11-08T10:30:00Z",
    group_name: "default",
    comment: "Sample comment 1",
    data_annotations: {
      outcome: {
        comment: "Outcome comment 1",
        color: "blue"
      }
    },
    organization_id: "3ff3f3f4-a950-4d65-9043-90d8100ded5c"
  },
  {
    goal: 75,
    outcome: 65,
    timestamp: "2024-11-09T11:00:00Z",
    group_name: "default",
    comment: "Sample comment 2",
    data_annotations: {
      outcome: {
        comment: "Outcome comment 2",
        color: "green"
      }
    },
    organization_id: "59291e40-b489-47e0-bba0-0862e19802b1"
  }
]

request.body = request_body.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "DataObject Ids:"
  puts data
else
  puts "Request error: #{response.message}"
end
