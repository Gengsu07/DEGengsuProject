# End To End Data Pipeline Games Released 2024

_This project can be running locally using docker and cloud (in my case Google Cloud)_

### What is going to achieve?

> Many games released every day in multi platform like PC, Xbox and even in mobiles. As enthusiast, we want discover how many games released each month in 2024 and how is the distribution?

---

## Cloud Pipeline:

![](assets\gengsudeproject_cloud.png)

1. The source data is from Rawg API
2. Mage orchestrate update rawg games data weekly
3. Data ingested/fetched using pipeline `rawg_extract_bigquery` with two block steps in Mage then upload the data to BigQuery data warehouse.
4. Pipeline then trigger data transformation using DBT pipeline `rawg_dbt_bigquery` inside Mage
5. The transformed data then saved in Bigquery Warehouse with partition by DAY for ready to analytics purpose
6. Dashboard created using metabase
7. Mage and Metabase deployed in Google Cloud using Terraform

---

Mage AI hosted on Google Cloud: [https://gengsudezoomcamp1-lhyfb2n2qq-wl.a.run.app](https://gengsudezoomcamp1-lhyfb2n2qq-wl.a.run.app)
viewer account:
email: viewer@gmail.com
password: viewer123

![1712206355848](image/README/1712206355848.png)

---

Metabase hosted on Google Cloud: [https://gengsudezoomcamp1-metabase-lhyfb2n2qq-wl.a.run.app](https://gengsudezoomcamp1-metabase-lhyfb2n2qq-wl.a.run.app)

![1712206254213](image/README/1712206254213.png)
[view the dashboard publicly here](http://gengsudezoomcamp1-metabase-lhyfb2n2qq-wl.a.run.app/public/dashboard/2bf30e19-d241-4a67-9330-bab53c9706e4)

### Reproducibility

1. Clone this repo, and create Rawg API here: `https://rawg.io/apidocs`
2. Prepare service-account-json from Google Cloud. For easy deployment purpose only, we can use role as Owner.
3. Replace 'dev-' in dev-secrets.toml in .dlt and dev-profiles.yml inside GengsuDEZoomcamp/bg_rawg. Don't forget to fill credential details here.
4. Install gcloud SDK
5. login google cloud via cli:

```shell
gcloud auth application-default login
```

6. enable cloud filestore api:
   ```shell
   https://console.developers.google.com/apis/api/file.googleapis.com/overview?project=yourprojectid
   ```
7. cd Terraform then:

```shell
# init project
terraform init

# plan
terraform plan

# apply
terraform apply
```

> terraform then will create and setting the instances.

---

## Local Pipeline

![](assets\gengsudeproject_local.png)

there are some containers we spin up:

- Postgres as Data Warehouse
- Mage as workflow orchestration, includes DBT natively supported inside mage
- Metabase for dashboard
- python container as runner to trigger initial data fetching

> So, everything is configured in docker-compose-local.yml . When started, it will create 2 database, one for rawg games data and one for metabase. Then, after all container ready/started python runner container will trigger mage to make first load via API call

### Reproducibility

1. Clone this repo, and create Rawg API here: `https://rawg.io/apidocs`
2. Replace 'dev-' in dev-secrets.toml in .dlt and dev-profiles.yml inside GengsuDEZoomcamp/rawg. Don't forget to fill match postgres credential if you have edited it.
3. ```docker
   docker-compose -f docker-compose-local.yml up
   ```
