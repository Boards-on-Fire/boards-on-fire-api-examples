using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

var boardsOnFireApiUrl = "YOUR URL"; // exempel: https://my-company.boardsonfireapp.com/api/v5/
var apiKey = "YOUR API KEY";
var entityName = "YOUR ENTITY NAME";

using (var client = new HttpClient())
{
    client.BaseAddress = new Uri(boardsOnFireApiUrl);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

    try
    {
        // Entity with string fields production_line and stop_reason
        var requestBody = new
        {
            entity_objects = new[]
            {
                new
                {
                    production_line = "line1",
                    stop_reason = "failure",
                    organization_id = Guid.Parse("3ff3f3f4-a950-4d65-9043-90d8100ded5c")
                },
                new
                {
                    production_line = "line2",
                    stop_reason = "no reason",
                    organization_id = Guid.Parse("59291e40-b489-47e0-bba0-0862e19802b1")
                }
            },
            delete_others = false
        };

        var jsonContent = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

        var response = await client.PostAsync($"entities/{entityName}/entityobjects/import", httpContent);
        response.EnsureSuccessStatusCode();

        var data = await response.Content.ReadAsStringAsync();
        Console.WriteLine("EntityObject Ids:");
        Console.WriteLine(data);
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine($"Request error: {e.Message}");
    }
}
