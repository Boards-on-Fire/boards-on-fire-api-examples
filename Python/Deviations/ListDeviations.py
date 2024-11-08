import requests
import json

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

request_body = {
    "page": 1,
    "page_size": 10
}

try:
    response = requests.post(f"{boards_on_fire_api_url}/deviations/list", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("Deviations:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
