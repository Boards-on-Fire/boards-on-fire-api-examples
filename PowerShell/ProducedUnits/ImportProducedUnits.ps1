# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
$requestBody = @(
    @{
        external_id = "EXT12345"
        work_line_external_id = "WL12345"
        status = "Passed"
        produced_at = "2024-11-08T10:30:00Z"
        serial_number = "SN123456789"
        error_code = $null
        part_number = "PN987654321"
    },
    @{
        external_id = "EXT67890"
        work_line_external_id = "WL67890"
        status = "Failed"
        produced_at = "2024-11-08T11:30:00Z"
        serial_number = "SN987654321"
        error_code = "ERR002"
        part_number = "PN123456789"
    }
)

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json -Depth 10

# Send POST request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/producedunits/import" -Method Post -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "Produced Units result:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
