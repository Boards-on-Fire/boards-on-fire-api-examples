# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$deviationId = "YOUR DEVIATION ID"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Send DELETE request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/deviations/$deviationId" -Method Delete -Headers $headers

    Write-Output "Deviation deleted successfully."
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
