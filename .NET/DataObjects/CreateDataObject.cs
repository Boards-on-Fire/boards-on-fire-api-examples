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
        // Data Source with numeric fields goal and outcome
        var requestBody = new
        {
            goal = 50,
            outcome = 40,
            timestamp = "2024-11-08T10:30:00Z",
            group_name = "default",
            comment = "Sample comment",
            data_annotations = new
            {
                outcome = new
                {
                    comment = "Outcome comment",
                    color = "blue"
                }
            },
            organization_id = Guid.Parse(organizationId)
        };

        var jsonContent = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

        var response = await client.PostAsync($"datasources/{dataSourceName}/dataobjects", httpContent);
        response.EnsureSuccessStatusCode();

        var data = await response.Content.ReadAsStringAsync();
        Console.WriteLine("DataObject:");
        Console.WriteLine(data);
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine($"Request error: {e.Message}");
    }
}
