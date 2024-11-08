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

# Send GET request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/datasources/$dataSourceName/dataobjects/$dataObjectId" -Method Get -Headers $headers

    Write-Output "DataObject:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
