# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$dataSourceName = "YOUR DATA SOURCE NAME"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
$requestBody = @{
    page = 1
    page_size = 10
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json

# Send POST request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/datasources/$dataSourceName/dataobjects/list" -Method Post -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "DataObjects:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}

