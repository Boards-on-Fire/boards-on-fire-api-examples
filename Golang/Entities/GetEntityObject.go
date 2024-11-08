package main

import (
    "fmt"
    "net/http"
    "io/ioutil"
)

func main() {
    boardsOnFireApiUrl := "YOUR URL" // example: https://my-company.boardsonfireapp.com/api/v5/
    apiKey := "YOUR API KEY"
    entityName := "YOUR ENTITY NAME"
    entityObjectId := "YOUR ENTITY OBJECT ID"

    client := &http.Client{}

    req, err := http.NewRequest("GET", fmt.Sprintf("%s/entities/%s/entityObjects/%s", boardsOnFireApiUrl, entityName, entityObjectId), nil)
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

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println("Error reading response body:", err)
        return
    }

    fmt.Println("EntityObject:")
    fmt.Println(string(body))
}