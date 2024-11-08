import requests
import json

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
deviation_id = "YOUR DEVIATION ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

# Update field cause_description
request_body = {
    "cause_description": "Something went wrong in production."
}

try:
    response = requests.patch(f"{boards_on_fire_api_url}/deviations/{deviation_id}", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("Deviation:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")

