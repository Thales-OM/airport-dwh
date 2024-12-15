{{ config(
    materialized='table',
    schema='dwh_detailed'
) }}

SELECT
    ticket_no,
    book_ref AS booking_id,
    passenger_id,
    passanger_name,
    contact_data,
    CURRENT_TIMESTAMP AS load_timestamp,
    'source_system' AS source
FROM {{ ref('tickets') }}