
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/



with source as (
    select * from {{ source('rawg', 'rawg') }}
    ),
renamed as (
    select
        _dlt_id,
        slug,
        name,
        playtime,
       cast(released as timestamp) as released,
        tba,
        background_image,
        rating,
        rating_top,
        ratings_count,
        reviews_text_count,
        added,
        added_by_status__yet,
        added_by_status__owned,
        added_by_status__beaten,
        added_by_status__toplay,
        added_by_status__dropped,
        added_by_status__playing,
        suggestions_count,
        updated,
        reviews_count,
        saturated_color,
        dominant_color,
        esrb_rating__id,
        esrb_rating__name,
        esrb_rating__slug,
        esrb_rating__name_en,
        esrb_rating__name_ru,
        community_rating
    from source
        )

select * from renamed