import requests
import json
from uuid import UUID

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
organization_id = "YOUR ORGANIZATION ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

request_body = {
    "date": "2024-11-08",
    "deviation_category": str(UUID("514bec1f-c835-4dca-8379-ea17b7014757")),  # Deviation Category Id
    "deviation_type": str(UUID("3894c7bc-5113-4e51-be20-985ec10cbadf")),  # Deviation Type Id
    "discard": False,
    "name": "Stop in production",
    "organization_id": str(UUID(organization_id)),
    "responsible": str(UUID("081b3310-4980-4c3f-a7c1-9bce5d315be3")),  # User id
    "risk_consequence": 1.0,
    "risk_probability": 3.0,
    "source": "Deviation System",
    "status": 20
}

try:
    response = requests.post(f"{boards_on_fire_api_url}/deviations", headers=headers, data=json.dumps(request_body))
    response.raise_for_status()
    data = response.json()
    print("Deviation:")
    print(data)
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
