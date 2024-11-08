# Base data
$boardsOnFireApiUrl = "YOUR URL" # example: https://my-company.boardsonfireapp.com/api/v5/
$apiKey = "YOUR API KEY"
$entityName = "YOUR ENTITY NAME"

# Headers
$headers = @{
    "x-api-key" = $apiKey
    "Accept" = "application/json"
}

# Request body
# Entity with string fields production_line and stop_reason
$requestBody = @{
    entity_objects = @(
        @{
            production_line = "line1"
            stop_reason = "failure"
            organization_id = [Guid]::Parse("3ff3f3f4-a950-4d65-9043-90d8100ded5c")
        },
        @{
            production_line = "line2"
            stop_reason = "no reason"
            organization_id = [Guid]::Parse("59291e40-b489-47e0-bba0-0862e19802b1")
        }
    )
    delete_others = $false
}

# Convert request body to JSON
$jsonContent = $requestBody | ConvertTo-Json -Depth 10

# Send POST request
try {
    $response = Invoke-RestMethod -Uri "$boardsOnFireApiUrl/entities/$entityName/entityobjects/import" -Method Post -Headers $headers -Body $jsonContent -ContentType "application/json"

    Write-Output "EntityObject Ids:"
    Write-Output $response
}
catch {
    Write-Output "Request error: $($_.Exception.Message)"
}




