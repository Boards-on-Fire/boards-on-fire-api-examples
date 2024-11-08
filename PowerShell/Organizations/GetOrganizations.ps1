# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Send GET request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/organizations" -Method Get -Headers $headers

    Write-Output "Organizations List:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
