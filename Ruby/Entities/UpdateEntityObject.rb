require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"
entity_object_id = "YOUR ENTITY OBJECT ID"

uri = URI.parse("#{boards_on_fire_api_url}/entities/#{entity_name}/entityobjects/#{entity_object_id}")
request = Net::HTTP::Patch.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

# Entity with string fields production_line and stop_reason
# Update stop_reason
request_body = {
  stop_reason: "no reason"
}

request.body = request_body.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "EntityObject:"
  puts data
else
  puts "Request error: #{response.message}"
end
