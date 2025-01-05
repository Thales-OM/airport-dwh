{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    b.book_ref,
    f.flight_id,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source,
    md5(b.book_ref || f.flight_id) AS hash_key
FROM {{ ref('bookings') }} b
JOIN {{ ref('ticket_flights') }} tf ON b.book_ref = tf.book_ref
JOIN {{ ref('flights') }} f ON tf.flight_id = f.flight_id