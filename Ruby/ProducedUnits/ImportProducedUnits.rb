require 'net/http'
require 'uri'
require 'json'

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"

uri = URI.parse("#{boards_on_fire_api_url}/producedunits/import")
request = Net::HTTP::Post.new(uri)
request["Content-Type"] = "application/json"
request["x-api-key"] = api_key

request_body = [
  {
    external_id: "EXT12345",
    work_line_external_id: "WL12345",
    status: "Passed",
    produced_at: "2024-11-08T10:30:00Z",
    serial_number: "SN123456789",
    error_code: nil,
    part_number: "PN987654321"
  },
  {
    external_id: "EXT67890",
    work_line_external_id: "WL67890",
    status: "Failed",
    produced_at: "2024-11-08T11:30:00Z",
    serial_number: "SN987654321",
    error_code: "ERR002",
    part_number: "PN123456789"
  }
]

request.body = request_body.to_json

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  http.request(request)
end

if response.is_a?(Net::HTTPSuccess)
  data = JSON.parse(response.body)
  puts "Produced Units result:"
  puts data
else
  puts "Request error: #{response.message}"
end
