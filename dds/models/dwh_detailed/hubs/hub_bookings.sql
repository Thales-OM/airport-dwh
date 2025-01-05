{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    book_ref AS booking_id,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source,
    md5(book_ref) AS hash_key
FROM {{ ref('bookings') }}
GROUP BY book_ref