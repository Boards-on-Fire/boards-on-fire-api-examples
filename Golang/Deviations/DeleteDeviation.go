package main

import (
    "fmt"
    "net/http"
)

func main() {
    boardsOnFireApiUrl := "YOUR URL" // example: https://my-company.boardsonfireapp.com/api/v5/
    apiKey := "YOUR API KEY"
    deviationId := "YOUR DEVIATION ID"

    client := &http.Client{}

    req, err := http.NewRequest("DELETE", fmt.Sprintf("%s/deviations/%s", boardsOnFireApiUrl, deviationId), nil)
    if err != nil {
        fmt.Println("Error creating request:", err)
        return
    }

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

    fmt.Println("Deviation deleted successfully.")
}
