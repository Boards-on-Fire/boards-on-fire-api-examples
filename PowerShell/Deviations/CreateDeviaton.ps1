# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$organizationId = "YOUR ORGANIZATION ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
$requestBody = @{
    date = "2024-11-08"
    deviation_category = [Guid]::Parse("514bec1f-c835-4dca-8379-ea17b7014757") # Deviation Category Id
    deviation_type = [Guid]::Parse("3894c7bc-5113-4e51-be20-985ec10cbadf") # Deviation Type Id
    discard = $false
    name = "Stop in production"
    organization_id = [Guid]::Parse($organizationId)
    responsible = [Guid]::Parse("081b3310-4980-4c3f-a7c1-9bce5d315be3") # User id
    risk_consequence = 1.0
    risk_probability = 3.0
    source = "Deviation System"
    status = 20
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json -Depth 10

# Send POST request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/deviations" -Method Post -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "Deviation:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
