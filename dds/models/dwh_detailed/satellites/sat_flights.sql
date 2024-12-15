{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    flight_id AS flight_id,
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    departure_airport,
    arrival_airport,
    status,
    aircraft_code,
    actual_departure,
    actual_arrival,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source
FROM {{ ref('flights') }}