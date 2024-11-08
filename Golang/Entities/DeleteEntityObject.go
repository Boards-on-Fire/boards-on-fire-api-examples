package main

import (
    "fmt"
    "net/http"
)

func main() {
    boardsOnFireApiUrl := "YOUR URL" // example: https://my-company.boardsonfireapp.com/api/v5/
    apiKey := "YOUR API KEY"
    entityName := "YOUR ENTITY NAME"
    entityObjectId := "YOUR ENTITY OBJECT ID"

    client := &http.Client{}

    req, err := http.NewRequest("DELETE", fmt.Sprintf("%s/entities/%s/entityObjects/%s", boardsOnFireApiUrl, entityName, entityObjectId), nil)
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

    fmt.Println("EntityObject deleted successfully.")
}
