# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$deviationId = "YOUR DEVIATION ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
# Update field cause_description
$requestBody = @{
    cause_description = "Something went wrong in production."
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json

# Send PATCH request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/deviations/$deviationId" -Method Patch -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "Deviation:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
