# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$entityName = "YOUR ENTITY NAME"
$entityObjectId = "YOUR ENTITY OBJECT ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
# Entity with string fields production_line and stop_reason
# Update stop_reason
$requestBody = @{
    stop_reason = "no reason"
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json

# Send PATCH request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/entities/$entityName/entityobjects/$entityObjectId" -Method Patch -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "EntityObject:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
