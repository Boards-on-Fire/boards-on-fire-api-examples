import requests
import json
from uuid import UUID

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

# Entity with string fields production_line and stop_reason
request_body = {
    "entity_objects": [
        {
            "production_line": "line1",
            "stop_reason": "failure",
            "organization_id": str(UUID("3ff3f3f4-a950-4d65-9043-90d8100ded5c"))
        },
        {
            "production_line": "line2",
            "stop_reason": "no reason",
            "organization_id": str(UUID("59291e40-b489-47e0-bba0-0862e19802b1"))
        }
    ],
    "delete_others": False
}

try:
    response = requests.post(f"{boards_on_fire_api_url}/entities/{entity_name}/entityobjects/import", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("EntityObject Ids:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
