package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "net/http"
    "github.com/google/uuid"
)

func main() {
    boardsOnFireApiUrl := "YOUR URL" // example: https://my-company.boardsonfireapp.com/api/v5/
    apiKey := "YOUR API KEY"
    entityName := "YOUR ENTITY NAME"

    client := &http.Client{}

    // Entity with string fields production_line and stop_reason
    requestBody := map[string]interface{}{
        "entity_objects": []map[string]interface{}{
            {
                "production_line": "line1",
                "stop_reason":     "failure",
                "organization_id": uuid.MustParse("3ff3f3f4-a950-4d65-9043-90d8100ded5c"),
            },
            {
                "production_line": "line2",
                "stop_reason":     "no reason",
                "organization_id": uuid.MustParse("59291e40-b489-47e0-bba0-0862e19802b1"),
            },
        },
        "delete_others": false,
    }

    jsonContent, err := json.Marshal(requestBody)
    if err != nil {
        fmt.Println("Error marshalling request body:", err)
        return
    }

    req, err := http.NewRequest("POST", fmt.Sprintf("%s/entities/%s/entityobjects/import", boardsOnFireApiUrl, entityName), bytes.NewBuffer(jsonContent))
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

    fmt.Println("EntityObject Ids:")
    fmt.Println(data)
}
