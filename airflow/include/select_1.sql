WITH passenger_stats AS (
    SELECT 
        st.passenger_id AS passenger_id,
        st.passenger_name as passenger_name, -- Пассажир уже уникален по ID
        COUNT(DISTINCT ltf.Flight_HK) AS flights_number,
        SUM(stf.amount) AS purchase_sum
    FROM 
        dwh_detailed.Link_Tickets_Flights ltf
    INNER JOIN 
        dwh_detailed.Sat_Tickets st 
            ON ltf.Ticket_HK = st.Ticket_HK
            AND date_trunc('day', CURRENT_TIMESTAMP) - INTERVAL '1 second' -- Вчерашний день относительно сегодняшней business_dt
                BETWEEN st.Effective_From AND st.Effective_To
    INNER JOIN 
        dwh_detailed.Sat_Ticket_Flights stf 
            ON ltf.Tickets_Flights_HK = stf.Tickets_Flights_HK
            AND date_trunc('day', CURRENT_TIMESTAMP) - INTERVAL '1 second' -- Вчерашний день относительно сегодняшней business_dt
                BETWEEN stf.Effective_From AND stf.Effective_To
    GROUP BY 
        st.passenger_id, st.passenger_name
)

, get_home_airport AS (
    SELECT DISTINCT ON (st.passenger_id)
        st.passenger_id as passenger_id,
        sa.Airport_Code as home_airport,
        COUNT(DISTINCT ltf.Flight_HK) as flights_from_home_airport
    FROM
        dwh_detailed.Link_Tickets_Flights ltf
    INNER JOIN 
        dwh_detailed.Sat_Tickets st 
            ON ltf.Ticket_HK = st.Ticket_HK
            AND date_trunc('day', CURRENT_TIMESTAMP) - INTERVAL '1 second' -- Вчерашний день относительно сегодняшней business_dt
                BETWEEN st.Effective_From AND st.Effective_To
    INNER JOIN
        dwh_detailed.Link_Flights_Airports lfa
            ON ltf.Flight_HK = lfa.Flight_HK
    INNER JOIN 
        dwh_detailed.Sat_Airports sa 
            ON lfa.Departure_Airport_HK = sa.Airport_HK
            AND date_trunc('day', CURRENT_TIMESTAMP) - INTERVAL '1 second' -- Вчерашний день относительно сегодняшней business_dt
                BETWEEN sa.Effective_From AND sa.Effective_To
    GROUP BY
        st.passenger_id, sa.Airport_Code
    ORDER BY
        st.passenger_id, COUNT(DISTINCT ltf.Flight_HK) DESC, sa.Airport_Code ASC
)

, ranked_passengers AS (
    SELECT 
        passenger_id,
        passenger_name,
        flights_number,
        purchase_sum,
        NTILE(100) OVER (ORDER BY purchase_sum DESC) AS percentile_rank
    FROM 
        passenger_stats
)

SELECT 
    CURRENT_TIMESTAMP AS created_at,
    rp.passenger_id as passenger_id,
    rp.passenger_name as passenger_name,
    rp.flights_number as flights_number,
    rp.purchase_sum as purchase_sum,
    ha.home_airport as home_airport,
    CASE 
        WHEN rp.percentile_rank <= 5 THEN '5'
        WHEN rp.percentile_rank <= 10 THEN '10'
        WHEN rp.percentile_rank <= 25 THEN '25'
        WHEN rp.percentile_rank <= 50 THEN '50'
        ELSE '50+'
    END AS customer_group
FROM 
    ranked_passengers rp
INNER JOIN 
    get_home_airport ha 
        ON rp.passenger_id = ha.passenger_id
;