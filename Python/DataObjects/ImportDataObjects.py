import requests
import json

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
data_source_name = "YOUR DATA SOURCE NAME"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

# Data Source with numeric fields goal and outcome
request_body = [
    {
        "goal": 50,
        "outcome": 40,
        "timestamp": "2024-11-08T10:30:00Z",
        "group_name": "default",
        "comment": "Sample comment 1",
        "data_annotations": {
            "outcome": {
                "comment": "Outcome comment 1",
                "color": "blue"
            }
        },
        "organization_id": "3ff3f3f4-a950-4d65-9043-90d8100ded5c"
    },
    {
        "goal": 75,
        "outcome": 65,
        "timestamp": "2024-11-09T11:00:00Z",
        "group_name": "default",
        "comment": "Sample comment 2",
        "data_annotations": {
            "outcome": {
                "comment": "Outcome comment 2",
                "color": "green"
            }
        },
        "organization_id": "59291e40-b489-47e0-bba0-0862e19802b1"
    }
]

try:
    response = requests.post(f"{boards_on_fire_api_url}/datasources/{data_source_name}/dataobjects/import", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("DataObject Ids:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
