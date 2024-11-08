# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$entityName = "YOUR ENTITY NAME"
$organizationId = "YOUR ORGANIZATION ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
# Entity with string fields production_line and stop_reason
$requestBody = @{
    production_line = "line1"
    stop_reason = "failure"
    organization_id = [Guid]::Parse($organizationId)
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json

# Send POST request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/entities/$entityName/entityobjects" -Method Post -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "EntityObject:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
