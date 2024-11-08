# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$deviationId = "YOUR DEVIATION ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Send GET request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/deviations/$deviationId" -Method Get -Headers $headers

    Write-Output "Deviation:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
