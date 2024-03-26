import datetime

import dlt
import pandas as pd
import requests
from tqdm import tqdm

url = "https://api.rawg.io/api/games"
api_key = "4ce3012ed2024e39861c8d0811fe28d3"
params = {"key": f"{api_key}", "page_size": 100}

current_date = datetime.datetime.now().date()
current_year = datetime.datetime.now().year
first_date_this_year = datetime.datetime(current_year, 1, 1).date()
params["dates"] = f"{first_date_this_year},{current_date}"


def parse_json(response):
    data = response.json()
    result = data["results"]
    df = pd.json_normalize(result)
    return df


def get_data(url, params):
    response = requests.get(url=url, params=params)
    response.raise_for_status()
    # data = response.json()
    # count = data["count"]
    # print(count)
    # page_amount = math.ceil(count / 40)
    # for page in range(1, page_amount)[:1]:
    #     params["page"] = page
    #     response = requests.get(url=url, params=params)
    #     df = parse_json(response)
    #     print(df.head())
    #     df.to_excel("rawg_games.xlsx", index=False)


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


if __name__ == "__main__":
    pipeline = dlt.pipeline(
        pipeline_name="rawg_bigquery", destination="bigquery", dataset_name="rawg"
    )
    load_info = pipeline.run(
        stream_download_jsonl(url, params),
        table_name="staging_rawg",
        write_disposition="replace",
    )
    print(load_info)
