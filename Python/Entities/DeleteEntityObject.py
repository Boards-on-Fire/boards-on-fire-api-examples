import requests

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
entity_name = "YOUR ENTITY NAME"
entity_object_id = "YOUR ENTITY OBJECT ID"

headers = {
    "x-api-key": api_key
}

try:
    response = requests.delete(f"{boards_on_fire_api_url}/entities/{entity_name}/entityObjects/{entity_object_id}", headers=headers)
    response.raise_for_status()
    print("EntityObject deleted successfully.")
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
