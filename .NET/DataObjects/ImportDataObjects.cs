using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

var boardsOnFireApiUrl = "YOUR URL"; // exempel: https://my-company.boardsonfireapp.com/api/v5/
var apiKey = "YOUR API KEY";
var dataSourceName = "YOUR DATA SOURCE NAME";

using (var client = new HttpClient())
{
    client.BaseAddress = new Uri(boardsOnFireApiUrl);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

    try
    {
        // Data Source with numeric fields goal and outcome
        var requestBody = new[]
        {
            new
            {
                goal = 50,
                outcome = 40,
                timestamp = "2024-11-08T10:30:00Z",
                group_name = "default",
                comment = "Sample comment 1",
                data_annotations = new
                {
                    outcome = new
                    {
                        comment = "Outcome comment 1",
                        color = "blue"
                    }
                },
                organization_id = Guid.Parse("3ff3f3f4-a950-4d65-9043-90d8100ded5c")
            },
            new
            {
                goal = 75,
                outcome = 65,
                timestamp = "2024-11-09T11:00:00Z",
                group_name = "default",
                comment = "Sample comment 2",
                data_annotations = new
                {
                    outcome = new
                    {
                        comment = "Outcome comment 2",
                        color = "green"
                    }
                },
                organization_id = Guid.Parse("59291e40-b489-47e0-bba0-0862e19802b1")
            }
        };

        var jsonContent = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

        var response = await client.PostAsync($"datasources/{dataSourceName}/dataobjects/import", httpContent);
        response.EnsureSuccessStatusCode();

        var data = await response.Content.ReadAsStringAsync();
        Console.WriteLine("DataObject Ids:");
        Console.WriteLine(data);
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine($"Request error: {e.Message}");
    }
}
