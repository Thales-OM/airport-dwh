{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    tf.ticket_no,
    f.flight_id,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source,
    md5(tf.ticket_no || f.flight_id) AS hash_key
FROM {{ ref('ticket_flights') }} tf
JOIN {{ ref('flights') }} f ON tf.flight_id = f.flight_id