with source as (
    select * from {{ source('stg_rawg', 'rawg__platforms') }}
),
renamed as (
    select
        platform__id,
        platform__name,
        platform__slug,
        _dlt_parent_id,
        _dlt_list_idx,
        _dlt_id
    from source
)

select * from renamed