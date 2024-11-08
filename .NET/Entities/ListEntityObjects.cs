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
        var requestBody = new
        {
            page = 1,
            page_size = 10
        };

        var jsonContent = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

        var response = await client.PostAsync($"entities/{entityName}/entityobjects/list", httpContent);
        response.EnsureSuccessStatusCode();

        var data = await response.Content.ReadAsStringAsync();
        Console.WriteLine("EntityObjects:");
        Console.WriteLine(data);
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine($"Request error: {e.Message}");
    }
}
