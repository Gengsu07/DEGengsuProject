
-- Use the `ref` function to select from other models

with source as (
    select * from {{ source('rawg', 'rawg__genres') }}
),
renamed as (
    select
        array_to_string(array_agg(name ORDER BY name ASC),',') as name,
        array_to_string(array_agg(slug ORDER BY slug ASC),',') as slug, 
        _dlt_parent_id
   from source
   group by _dlt_parent_id
)



select * from renamed