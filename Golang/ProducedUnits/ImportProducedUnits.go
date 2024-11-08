package main

import (
    "bytes"
    "encoding/json"
    "fmt"
    "net/http"
)

func main() {
    boardsOnFireApiUrl := "YOUR URL" // example: https://my-company.boardsonfireapp.com/api/v5/
    apiKey := "YOUR API KEY"

    client := &http.Client{}

    requestBody := []map[string]interface{}{
        {
            "external_id":           "EXT12345",
            "work_line_external_id": "WL12345",
            "status":                "Passed",
            "produced_at":           "2024-11-08T10:30:00Z",
            "serial_number":         "SN123456789",
            "error_code":            nil,
            "part_number":           "PN987654321",
        },
        {
            "external_id":           "EXT67890",
            "work_line_external_id": "WL67890",
            "status":                "Failed",
            "produced_at":           "2024-11-08T11:30:00Z",
            "serial_number":         "SN987654321",
            "error_code":            "ERR002",
            "part_number":           "PN123456789",
        },
    }

    jsonContent, err := json.Marshal(requestBody)
    if err != nil {
        fmt.Println("Error marshalling request body:", err)
        return
    }

    req, err := http.NewRequest("POST", fmt.Sprintf("%s/producedunits/import", boardsOnFireApiUrl), bytes.NewBuffer(jsonContent))
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

    fmt.Println("Produced Units result:")
    fmt.Println(data)
}
