require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"

uri = URI.parse("#{boards_on_fire_api_url}/entities/#{entity_name}/entityobjects/import")
request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

# Entity with string fields production_line and stop_reason
request_body = {
  entity_objects: [
    {
      production_line: "line1",
      stop_reason: "failure",
      organization_id: "3ff3f3f4-a950-4d65-9043-90d8100ded5c"
    },
    {
      production_line: "line2",
      stop_reason: "no reason",
      organization_id: "59291e40-b489-47e0-bba0-0862e19802b1"
    }
  ],
  delete_others: false
}

request.body = request_body.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "EntityObject Ids:"
  puts data
else
  puts "Request error: #{response.message}"
end
