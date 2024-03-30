import datetime
import json
import os

import dlt
import requests
from tenacity import retry, stop_after_attempt, wait_fixed
from tqdm import tqdm

url = "https://api.rawg.io/api/games"
api_key = os.getenv("RAWG_API_KEY")
params = {"key": f"{api_key}", "page_size": 100}

current_date = datetime.datetime.now().date()
current_year = datetime.datetime.now().year
first_date_this_year = datetime.datetime(current_year, 1, 1).date()
params["dates"] = f"{first_date_this_year},{current_date}"


@retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
def stream_download_jsonl(url, params,data):
    results = []
    lastpage = False
    count = data["count"]
    with tqdm(total=count) as pbar:
        results.extend(data["results"])
        pbar.update(len(data["results"]))
        if data["next"] is None:
            lastpage = True
        while not lastpage:
            next_url = data["next"]
            response = requests.get(url=next_url, stream=True)
            try:
                data = response.json()
            except json.decoder.JSONDecodeError:
                print(f"Error decoding JSON: {response.content}")
                continue
            results.extend(data["results"])
            pbar.update(len(data["results"]))
            if data["next"] is None:
                lastpage = True
    for result in results:
        yield result


@data_loader
def data_load(data,*args, **kwargs):
    if data['count'] >0:
        pipeline = dlt.pipeline(
            pipeline_name="rawg_bigquery",
            destination="bigquery",
            dataset_name="rawg",
        )
        load_info = pipeline.run(
            stream_download_jsonl(url, params, data),
            table_name="rawg",
            write_disposition="replace",
        )
        print(load_info)
