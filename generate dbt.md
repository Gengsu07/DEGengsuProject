### Postgres

`dbt run-operation generate_source --args "{'schema_name': 'staging'}"`
`dbt run-operation generate_base_model --args '{"source_name": "stg_rawg", "table_name": "rawg"}'`
`dbt run-operation generate_base_model --args '{"source_name": "stg_rawg", "table_name": "rawg\_\_genres"}'`
`dbt run-operation generate_model_yaml --args '{"model_names": ["stg_rawg"]}'`

### BigQuery

`dbt run-operation generate_source --args "{'schema_name': 'staging_rawg'}"`
`dbt run-operation generate_base_model --args '{"source_name": "staging_rawg", "table_name": "rawg"}' `
`dbt run-operation generate_base_model --args '{"source_name": "staging_rawg", "table_name": "rawg__genres"}' `
`dbt run-operation generate_base_model --args '{"source_name": "staging_rawg", "table_name": "rawg__platforms"}' `

`dbt run-operation generate_model_yaml --args "{'model_names': ['stg_rawg']}"`
