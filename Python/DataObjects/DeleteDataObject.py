import requests

boards_on_fire_api_url = "YOUR URL"  # example: https://my-company.boardsonfireapp.com/api/v5/
api_key = "YOUR API KEY"
data_source_name = "YOUR DATA SOURCE NAME"
data_object_id = "YOUR DATA OBJECT ID"

headers = {
    "Content-Type": "application/json",
    "x-api-key": api_key
}

try:
    response = requests.delete(f"{boards_on_fire_api_url}/datasources/{data_source_name}/dataobjects/{data_object_id}", headers=headers)
    response.raise_for_status()
    print("Data object deleted successfully.")
except requests.exceptions.RequestException as e:
    print(f"Request error: {e}")
