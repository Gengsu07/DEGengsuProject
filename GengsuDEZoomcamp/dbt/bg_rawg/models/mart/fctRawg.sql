-- {{ config(schema='fctTable')}}

{{config(
	materialized = 'incremental',
	incremental_strategy = 'insert_overwrite',
	partition_by = {
		'field': 'released',
		'data_type': 'timestamp',
		'granularity': 'day'
	}
)}}

with rawg as (
    select 
    slug,
	name,
	playtime,
	released,
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
	_dlt_id,
	esrb_rating__id,
	esrb_rating__name,
	esrb_rating__slug,
	esrb_rating__name_en,
	esrb_rating__name_ru,
	community_rating
    from {{ref('stg_rawg')}}
),
genres as (
    select * from {{ref('stg_genres')}}
),
platforms as (
    select * from {{ref('stg_platforms')}}
)

select 
r.*,
g.name as genre_name,
p.platform_name as platform_name
from rawg r
left join genres g on r._dlt_id = g._dlt_parent_id
left join platforms p on r._dlt_id = p._dlt_parent_id