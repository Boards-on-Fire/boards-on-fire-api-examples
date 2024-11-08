import requests

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
organization_id = "YOUR ORGANIZATION ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

try:
    response = requests.get(f"{boards_on_fire_api_url}/organizations/{organization_id}", headers=headers)
    response.raise_for_status()
    data = response.json()
    print("Organization:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")

