using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

var boardsOnFireApiUrl = "YOUR URL"; // exempel: https://my-company.boardsonfireapp.com/api/v5/
var apiKey = "YOUR API KEY";
var deviationId = "YOUR DEVIATION ID";

using (var client = new HttpClient())
{
    client.BaseAddress = new Uri(boardsOnFireApiUrl);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
    client.DefaultRequestHeaders.Add("x-api-key", apiKey);

    try
    {
        var response = await client.GetAsync($"deviations/{deviationId}");
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