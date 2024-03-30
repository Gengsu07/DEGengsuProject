import io
import pandas as pd
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
import datetime
import json
import os
import requests

url = "https://api.rawg.io/api/games"
api_key = os.getenv("RAWG_API_KEY")
params = {"key": f"{api_key}", "page_size": 100}

current_date = datetime.datetime.now().date()
current_year = datetime.datetime.now().year
first_date_this_year = datetime.datetime(current_year, 3, 20).date()
params["dates"] = f"{first_date_this_year},{current_date}"

@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    response = requests.get(url, params=params, stream=True)
    response.raise_for_status()  # Raise an HTTPError for bad responses
    data = response.json()
    count = data['count']
    print(f"Total Games release 2024 available:{count}")

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
