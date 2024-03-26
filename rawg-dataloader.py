import datetime

import dlt
import requests
from tqdm import tqdm

url = "https://api.rawg.io/api/games"
api_key = "4ce3012ed2024e39861c8d0811fe28d3"
params = {"key": f"{api_key}", "page_size": 100}

current_date = datetime.datetime.now().date()
current_year = datetime.datetime.now().year
first_date_this_year = datetime.datetime(current_year, 1, 1).date()
params["dates"] = f"{first_date_this_year},{current_date}"


def stream_download_jsonl(url, params):
    results = []
    lastpage = False
    response = requests.get(url, params=params, stream=True)
    response.raise_for_status()  # Raise an HTTPError for bad responses
    data = response.json()
    count = data["count"]
    print(f"Total Games release 2024 available:{count}")
    with tqdm(total=count) as pbar:
        while not lastpage:
            next_url = data["next"]
            response = requests.get(url=next_url, stream=True)
            data = response.json()
            results.extend(data["results"])
            pbar.update(len(data["results"]))
            if data["next"] is None:
                lastpage = True
    for result in results:
        yield result


@data_loader
def data_load():
    pipeline = dlt.pipeline(
        pipeline_name="rawg_bigquery", destination="bigquery", dataset_name="rawg"
    )
    load_info = pipeline.run(
        stream_download_jsonl(url, params),
        table_name="staging_rawg",
        write_disposition="replace",
    )
    print(load_info)