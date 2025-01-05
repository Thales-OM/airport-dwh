{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    book_ref AS booking_id,
    book_date,
    total_amount,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source
FROM {{ ref('bookings') }}