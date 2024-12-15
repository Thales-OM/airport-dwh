{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    aircraft_code AS aircraft_id,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source,
    md5(aircraft_code) AS hash_key
FROM {{ ref('aircrafts') }}
GROUP BY aircraft_code