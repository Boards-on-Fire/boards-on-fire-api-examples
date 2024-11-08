import requests
import json

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"
entity_object_id = "YOUR ENTITY OBJECT ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

# Entity with string fields production_line and stop_reason
# Update stop_reason
request_body = {
    "stop_reason": "no reason"
}

try:
    response = requests.patch(f"{boards_on_fire_api_url}/entities/{entity_name}/entityobjects/{entity_object_id}", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("EntityObject:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
