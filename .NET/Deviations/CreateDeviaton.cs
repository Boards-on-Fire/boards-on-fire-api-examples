using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

var boardsOnFireApiUrl = "YOUR URL"; // exempel: https://my-company.boardsonfireapp.com/api/v5/
var apiKey = "YOUR API KEY";
var organizationId = "YOUR ORGANIZATION ID";

using (var client = new HttpClient())
{
    client.BaseAddress = new Uri(boardsOnFireApiUrl);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

    try
    {
        var requestBody = new
        {
            date = "2024-11-08",
            deviation_category = Guid.Parse("514bec1f-c835-4dca-8379-ea17b7014757"), // Deviation Category Id
            deviation_type = Guid.Parse("3894c7bc-5113-4e51-be20-985ec10cbadf"), // Deviation Type Id
            discard = false,
            name = "Stop in production",
            organization_id = Guid.Parse(organizationId),
            responsible = Guid.Parse("081b3310-4980-4c3f-a7c1-9bce5d315be3"), // User id
            risk_consequence = 1.0,
            risk_probability = 3.0,
            source = "Deviation System",
            status = 20
        };

        var jsonContent = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

        var response = await client.PostAsync($"deviations", httpContent);
        response.EnsureSuccessStatusCode();

        var data = await response.Content.ReadAsStringAsync();
        Console.WriteLine("Deviation:");
        Console.WriteLine(data);
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine($"Request error: {e.Message}");
    }
}
