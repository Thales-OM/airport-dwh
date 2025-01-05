{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    airport_code AS airport_id,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source,
    md5(airport_code) AS hash_key
FROM {{ ref('airports') }}
GROUP BY airport_code