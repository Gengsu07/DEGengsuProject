dbt run-operation generate_source --args "{'schema_name': 'staging'}"
dbt run-operation generate_base_model --args '{"source_name": "stg_rawg", "table_name": "rawg"}'
dbt run-operation generate_base_model --args '{"source_name": "stg_rawg", "table_name": "rawg__genres"}'
dbt run-operation generate_model_yaml --args '{"model_names": ["stg_rawg"]}'


