
-- Use the `ref` function to select from other models

with source as (
    select * from {{ source('staging_rawg', 'rawg__genres') }}
),
renamed as (
    select
       id,
       name,
       slug,
       _dlt_parent_id,
       _dlt_id
   from source
)



select * from renamed