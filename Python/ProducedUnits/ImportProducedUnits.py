import requests
import json

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

request_body = [
    {
        "external_id": "EXT12345",
        "work_line_external_id": "WL12345",
        "status": "Passed",
        "produced_at": "2024-11-08T10:30:00Z",
        "serial_number": "SN123456789",
        "error_code": None,
        "part_number": "PN987654321"
    },
    {
        "external_id": "EXT67890",
        "work_line_external_id": "WL67890",
        "status": "Failed",
        "produced_at": "2024-11-08T11:30:00Z",
        "serial_number": "SN987654321",
        "error_code": "ERR002",
        "part_number": "PN123456789"
    }
]

try:
    response = requests.post(f"{boards_on_fire_api_url}/producedunits/import", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("Produced Units result:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
