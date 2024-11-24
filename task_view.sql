SELECT 
    a.airport_code,
    COALESCE(df.departure_flights_num, 0::bigint) AS departure_flights_num,
    COALESCE(af.arrival_flights_num, 0::bigint) AS arrival_flights_num,
    COALESCE(ap.arrival_psngr_num, 0::bigint) AS arrival_psngr_num
FROM 
    airports a
    LEFT JOIN ( SELECT flights.departure_airport AS airport_code,
        count(*) AS departure_flights_num
        FROM flights
        GROUP BY flights.departure_airport
    ) df 
        ON a.airport_code = df.airport_code
    LEFT JOIN ( SELECT flights.arrival_airport AS airport_code,
        count(*) AS arrival_flights_num
        FROM flights
        GROUP BY flights.arrival_airport) af 
        ON a.airport_code = af.airport_code
    LEFT JOIN ( SELECT f.arrival_airport AS airport_code,
        count(DISTINCT tf.ticket_no) AS arrival_psngr_num
        FROM flights f
            JOIN ticket_flights tf ON f.flight_id = tf.flight_id
        GROUP BY f.arrival_airport) ap 
        ON a.airport_code = ap.airport_code
ORDER BY 
    a.airport_code
;