using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

var boardsOnFireApiUrl = "YOUR URL"; // exempel: https://my-company.boardsonfireapp.com/api/v5/
var apiKey = "YOUR API KEY";

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
                external_id = "EXT12345",
                work_line_external_id = "WL12345",
                status = "Passed",
                produced_at = "2024-11-08T10:30:00Z",
                serial_number = "SN123456789",
                error_code = null,
                part_number = "PN987654321"
            },
            new
            {
                external_id = "EXT67890",
                work_line_external_id = "WL67890",
                status = "Failed",
                produced_at = "2024-11-08T11:30:00Z",
                serial_number = "SN987654321",
                error_code = "ERR002",
                part_number = "PN123456789"
            }
        };

        var jsonContent = JsonSerializer.Serialize(requestBody);
        var httpContent = new StringContent(jsonContent, Encoding.UTF8, "application/json");

        var response = await client.PostAsync($"producedunits/import", httpContent);
        response.EnsureSuccessStatusCode();

        var data = await response.Content.ReadAsStringAsync();
        Console.WriteLine("Produced Units result:");
        Console.WriteLine(data);
    }
    catch (HttpRequestException e)
    {
        Console.WriteLine($"Request error: {e.Message}");
    }
}
