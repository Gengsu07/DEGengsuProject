--- BigQuery
with df as (SELECT 
EXTRACT(MONTH FROM fr.released)AS `Month`,
FORMAT_DATE('%B', fr.released)AS `Month Name`, 
count(fr._dlt_id) AS `Count` 
FROM rawg_fctTable.fctRawg fr  
GROUP BY EXTRACT(MONTH FROM fr.released),
FORMAT_DATE('%B', fr.released))
select * from df
order by df.`Month` asc


SELECT 
'PC' AS `Platform`,
count(CASE WHEN LOWER(fr.platform_name) LIKE '%pc%' THEN _dlt_id END) AS `Count`
FROM  rawg_fctTable.fctRawg fr 
UNION ALL
SELECT 
'Linux',
count(CASE WHEN LOWER(fr.platform_name) LIKE '%linux%' THEN _dlt_id END) AS `Count`
FROM  rawg_fctTable.fctRawg fr 
UNION ALL
SELECT 
'macOS',
count(CASE WHEN LOWER(fr.platform_name) LIKE '%macos%' THEN _dlt_id END) AS `macOS`
FROM  rawg_fctTable.fctRawg fr 
UNION ALL
SELECT 
'PS5',
count(CASE WHEN LOWER(fr.platform_name) LIKE '%playStation 5%' THEN _dlt_id END) AS `PS5`
FROM  rawg_fctTable.fctRawg fr 
UNION ALL
SELECT 
'Nintendo',
count(CASE WHEN LOWER(fr.platform_name) LIKE '%nintendo switch%' THEN _dlt_id END) AS `Nintendo`
FROM  rawg_fctTable.fctRawg fr 
UNION ALL
SELECT 
'XBox',
count(CASE WHEN LOWER(fr.platform_name) LIKE '%xbox%' THEN _dlt_id END) AS `XBOX`
FROM  rawg_fctTable.fctRawg fr 
UNION ALL
SELECT 
'Android',
count(CASE WHEN LOWER(fr.platform_name) LIKE '%android%' THEN _dlt_id END) AS `Android`
FROM  rawg_fctTable.fctRawg fr 




--- Postgres
SELECT 
'PC' AS "Platform",
count(CASE WHEN fr.platform_name ILIKE '%PC%' THEN _dlt_id END) AS "Count"
FROM  rawg."rawg_fctTable"."fctRawg" fr 
UNION ALL
SELECT 
'Linux',
count(CASE WHEN fr.platform_name ILIKE '%Linux%' THEN _dlt_id END) AS "Count"
FROM  rawg."rawg_fctTable"."fctRawg" fr 
UNION ALL
SELECT 
'macOS',
count(CASE WHEN fr.platform_name ILIKE '%macOS%' THEN _dlt_id END) AS "macOS"
FROM  rawg."rawg_fctTable"."fctRawg" fr 
UNION ALL
SELECT 
'PS5',
count(CASE WHEN fr.platform_name ILIKE '%PlayStation 5%' THEN _dlt_id END) AS "PS5"
FROM  rawg."rawg_fctTable"."fctRawg" fr 
UNION ALL
SELECT 
'Nintendo',
count(CASE WHEN fr.platform_name ILIKE '%Nintendo Switch%' THEN _dlt_id END) AS "Nintendo"
FROM  rawg."rawg_fctTable"."fctRawg" fr 
UNION ALL
SELECT 
'XBox',
count(CASE WHEN fr.platform_name ILIKE '%Xbox%' THEN _dlt_id END) AS "XBOX"
FROM  rawg."rawg_fctTable"."fctRawg" fr 
UNION ALL
SELECT 
'Android',
count(CASE WHEN fr.platform_name ILIKE '%Android%' THEN _dlt_id END) AS "Android"
FROM  rawg."rawg_fctTable"."fctRawg" fr 


SELECT 
EXTRACT(MONTH  FROM fr.released)AS "Month",
TO_CHAR(fr.released, 'Month')AS "Month Name", 
count(fr._dlt_id) AS "Count" 
FROM rawg."rawg_fctTable"."fctRawg" fr 
GROUP BY EXTRACT(MONTH  FROM fr.released),TO_CHAR(fr.released, 'Month')