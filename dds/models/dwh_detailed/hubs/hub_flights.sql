{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    flight_id AS flight_id,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source,
    md5(flight_id::text) AS hash_key
FROM {{ ref('flights') }}
GROUP BY flight_id