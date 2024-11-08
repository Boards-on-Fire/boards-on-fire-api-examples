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
    organizationId := "YOUR ORGANIZATION ID"

    client := &http.Client{}

    requestBody := map[string]interface{}{
        "date":              "2024-11-08",
        "deviation_category": uuid.MustParse("514bec1f-c835-4dca-8379-ea17b7014757"), // Deviation Category Id
        "deviation_type":    uuid.MustParse("3894c7bc-5113-4e51-be20-985ec10cbadf"), // Deviation Type Id
        "discard":           false,
        "name":              "Stop in production",
        "organization_id":   uuid.MustParse(organizationId),
        "responsible":       uuid.MustParse("081b3310-4980-4c3f-a7c1-9bce5d315be3"), // User id
        "risk_consequence":  1.0,
        "risk_probability":  3.0,
        "source":            "Deviation System",
        "status":            20,
    }

    jsonContent, err := json.Marshal(requestBody)
    if err != nil {
        fmt.Println("Error marshalling request body:", err)
        return
    }

    req, err := http.NewRequest("POST", fmt.Sprintf("%s/deviations", boardsOnFireApiUrl), bytes.NewBuffer(jsonContent))
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

    fmt.Println("Deviation:")
    fmt.Println(data)
}
