{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    aircraft_code AS aircraft_id,
    model,
    range,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source
FROM {{ ref('aircrafts') }}