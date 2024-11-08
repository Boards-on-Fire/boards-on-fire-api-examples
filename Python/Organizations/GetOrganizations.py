import requests

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

try:
    response = requests.get(f"{boards_on_fire_api_url}/organizations", headers=headers)
    response.raise_for_status()
    data = response.json()
    print("Organizations List:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")


