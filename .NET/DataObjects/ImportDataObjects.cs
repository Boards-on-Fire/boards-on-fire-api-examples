using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

var boardsOnFireApiUrl = "YOUR URL"; // exempel: https://my-company.boardsonfireapp.com/api/v5/
var apiKey = "YOUR API KEY";
var dataSourceName = "YOUR DATA SOURCE NAME";
var organizationId = "YOUR ORGANIZATION ID";

using (var client = new HttpClient())
{
    client.BaseAddress = new Uri(boardsOnFireApiUrl);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

    try
    {
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
                organization_id = Guid.Parse(organizationId)
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
                organization_id = Guid.Parse(organizationId)
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
