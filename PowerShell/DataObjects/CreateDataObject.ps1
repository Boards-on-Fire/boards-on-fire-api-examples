# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$dataSourceName = "YOUR DATA SOURCE NAME"
$organizationId = "YOUR ORGANIZATION ID"

# Request Body
$requestBody = @{
    goal = 50
    outcome = 40
    timestamp = "2024-11-08T10:30:00Z"
    group_name = "default"
    comment = "Sample comment"
    data_annotations = @{
        outcome = @{
            comment = "Outcome comment"
            color = "blue"
        }
    }
    organization_id = $organizationId
}

# Serialize requestBody to JSON
$jsonContent = $requestBody | ConvertTo-Json -Depth 5

# Send POST request
try {
    $headers = @{
        "x-api-key" = $apiKey
        "Accept" = "application/json"
        "Content-Type" = "application/json"
    }

    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/datasources/$dataSourceName/dataobjects" -Method Post -Headers $headers -Body $jsonContent

    Write-Output "DataObject:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
