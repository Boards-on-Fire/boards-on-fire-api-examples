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
# Data Source with numeric fields goal and outcome
$requestBody = @(
    @{
        goal = 50
        outcome = 40
        timestamp = "2024-11-08T10:30:00Z"
        group_name = "default"
        comment = "Sample comment 1"
        data_annotations = @{
            outcome = @{
                comment = "Outcome comment 1"
                color = "blue"
            }
        }
        organization_id = "3ff3f3f4-a950-4d65-9043-90d8100ded5c"
    },
    @{
        goal = 75
        outcome = 65
        timestamp = "2024-11-09T11:00:00Z"
        group_name = "default"
        comment = "Sample comment 2"
        data_annotations = @{
            outcome = @{
                comment = "Outcome comment 2"
                color = "green"
            }
        }
        organization_id = "59291e40-b489-47e0-bba0-0862e19802b1"
    }
)

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json -Depth 10

# Send POST request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/datasources/$dataSourceName/dataobjects/import" -Method Post -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "DataObject Ids:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}
