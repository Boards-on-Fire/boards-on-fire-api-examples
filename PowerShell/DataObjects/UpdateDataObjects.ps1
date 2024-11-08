# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$dataSourceName = "YOUR DATA SOURCE NAME"
$dataObjectId = "YOUR DATA OBJECT ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
# Data Source with numeric fields goal and outcome
# Update field outcome
$requestBody = @{
    outcome = 45
    timestamp = "2024-11-07T10:30:00Z"
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json

# Send PATCH request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/datasources/$dataSourceName/dataobjects/$dataObjectId" -Method Patch -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "DataObject:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}

