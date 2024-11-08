require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"
organization_id = "YOUR ORGANIZATION ID"

uri = URI.parse("#{boards_on_fire_api_url}/entities/#{entity_name}/entityobjects")
request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

# Entity with string fields production_line and stop_reason
request_body = {
  production_line: "line1",
  stop_reason: "failure",
  organization_id: organization_id
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


