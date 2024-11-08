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

# Send DELETE request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/entities/$entityName/entityObjects/$entityObjectId" -Method Delete -Headers $headers

    Write-Output "EntityObject deleted successfully."
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
