import requests

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
deviation_id = "YOUR DEVIATION ID"

headers = {
    "x-api-key": api_key
}

try:
    response = requests.get(f"{boards_on_fire_api_url}/deviations/{deviation_id}", headers=headers)
    response.raise_for_status()
    data = response.json()
    print("Deviation:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
