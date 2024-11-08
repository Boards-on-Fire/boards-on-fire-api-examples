import requests
import json
from datetime import datetime

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
data_source_name = "YOUR DATA SOURCE NAME"
organization_id = "YOUR ORGANIZATION ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

request_body = {
    "goal": 50,
    "outcome": 40,
    "timestamp": "2024-11-08T10:30:00Z",
    "group_name": "default",
    "comment": "Sample comment",
    "data_annotations": {
        "outcome": {
            "comment": "Outcome comment",
            "color": "blue"
        }
    },
    "organization_id": organization_id
}

try:
    response = requests.post(f"{boards_on_fire_api_url}/datasources/{data_source_name}/dataobjects", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("DataObject:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
