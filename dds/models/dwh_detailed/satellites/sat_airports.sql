{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    airport_code AS airport_id,
    airport_name,
    city,
    coordinates_lon,
    coordinates_lat,
    timezone,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source 
FROM {{ ref('airports') }}