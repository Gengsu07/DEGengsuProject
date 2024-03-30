-- {{ config(schema='transform')}}


with source as (
    select * from {{ source('stg_rawg', 'rawg__platforms') }}
),
renamed as (
    select
        array_to_string(array_agg("platform__name" ORDER BY "platform__name" ASC),',') as platform_name,
        array_to_string(array_agg("platform__slug" ORDER BY "platform__slug" ASC),',') as platform_slug,
        _dlt_parent_id
    from source
    group by _dlt_parent_id
)

select * from renamed