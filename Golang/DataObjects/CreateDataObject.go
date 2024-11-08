package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "net/http"
    "time"
)

func main() {
    boardsOnFireApiUrl := "YOUR URL" // example: https://my-company.boardsonfireapp.com/api/v5/
    apiKey := "YOUR API KEY"
    dataSourceName := "YOUR DATA SOURCE NAME"
    organizationId := "YOUR ORGANIZATION ID"

    client := &http.Client{}

    // Data Source with numeric fields goal and outcome
    requestBody := map[string]interface{}{
        "goal":       50,
        "outcome":    40,
        "timestamp":  "2024-11-08T10:30:00Z",
        "group_name": "default",
        "comment":    "Sample comment",
        "data_annotations": map[string]interface{}{
            "outcome": map[string]interface{}{
                "comment": "Outcome comment",
                "color":   "blue",
            },
        },
        "organization_id": organizationId,
    }

    jsonContent, err := json.Marshal(requestBody)
    if err != nil {
        fmt.Println("Error marshalling request body:", err)
        return
    }

    req, err := http.NewRequest("POST", fmt.Sprintf("%s/datasources/%s/dataobjects", boardsOnFireApiUrl, dataSourceName), bytes.NewBuffer(jsonContent))
    if err != nil {
        fmt.Println("Error creating request:", err)
        return
    }

    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("x-api-key", apiKey)

    resp, err := client.Do(req)
    if err != nil {
        fmt.Println("Request error:", err)
        return
    }
    defer resp.Body.Close()

    if resp.StatusCode != http.StatusOK {
        fmt.Println("Request failed with status:", resp.Status)
        return
    }

    var data map[string]interface{}
    if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
        fmt.Println("Error decoding response:", err)
        return
    }

    fmt.Println("DataObject:")
    fmt.Println(data)
}
