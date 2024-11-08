import requests
import json
from uuid import UUID

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"
organization_id = "YOUR ORGANIZATION ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

# Entity with string fields production_line and stop_reason
request_body = {
    "production_line": "line1",
    "stop_reason": "failure",
    "organization_id": str(UUID(organization_id))
}

try:
    response = requests.post(f"{boards_on_fire_api_url}/entities/{entity_name}/entityobjects", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("EntityObject:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")


