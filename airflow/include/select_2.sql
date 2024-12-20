SELECT 
    CURRENT_TIMESTAMP AS created_at,
    f.Actual_Departure AS flight_date, -- Используем дату фактической отправки (судя по заданию нужно использовать любую одну из departure/arrival)
    GREATEST(a1.Airport_Code, a2.Airport_Code) AS airport_code, -- упорядочиваем аэропорты чтобы собрать полеты между двумя в обоих направлениях
    LEAST(a1.Airport_Code, a2.Airport_Code) AS linked_airport_code,
    COUNT(DISTINCT lfa.Flight_HK) FILTER (WHERE lfa.Arrival_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS flights_in,
    COUNT(DISTINCT lfa.Flight_HK) FILTER (WHERE lfa.Departure_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS flights_out,
    -- По заданию не очень понятно нужно ли считать чсило уникальных людей (passenger_id) или просто пассажирова (включая кейсы когда один человек летит в одну сторону 2+ раза)
    -- Поэтому я оставил вариант с подсчетом пассажиров (в нашей БД 1 билет = 1 пассажир)
    COUNT(DISTINCT ltf.Ticket_HK) FILTER (WHERE lfa.Arrival_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS passengers_in,
    COUNT(DISTINCT ltf.Ticket_HK) FILTER (WHERE lfa.Departure_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS passengers_out
FROM 
    dwh_detailed.Link_Flights_Airports lfa
INNER JOIN 
    dwh_detailed.Hub_Airports a1 ON lfa.Arrival_Airport_HK = a1.Airport_HK
INNER JOIN 
    dwh_detailed.Hub_Airports a2 ON lfa.Departure_Airport_HK = a2.Airport_HK
INNER JOIN 
    dwh_detailed.Sat_Flights f ON lfa.Flight_HK = f.Flight_HK
LEFT JOIN 
    dwh_detailed.Link_Tickets_Flights ltf ON f.Flight_HK = ltf.Flight_HK
GROUP BY 
    GREATEST(a1.Airport_Code, a2.Airport_Code), LEAST(a1.Airport_Code, a2.Airport_Code)

-- Нужно произвести аналогичную пару, но в другую сторону airport_code <-> linked_airport_code
UNION ALL

SELECT 
    CURRENT_TIMESTAMP AS created_at,
    f.Actual_Departure AS flight_date,
    LEAST(a1.Airport_Code, a2.Airport_Code) AS airport_code,
    GREATEST(a1.Airport_Code, a2.Airport_Code) AS linked_airport_code,
    COUNT(DISTINCT lfa.Flight_HK) FILTER (WHERE lfa.Arrival_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS flights_in,
    COUNT(DISTINCT lfa.Flight_HK) FILTER (WHERE lfa.Departure_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS flights_out,
    COUNT(DISTINCT ltf.Ticket_HK) FILTER (WHERE lfa.Arrival_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS passengers_in,
    COUNT(DISTINCT ltf.Ticket_HK) FILTER (WHERE lfa.Departure_Airport_HK = GREATEST(a1.Airport_Code, a2.Airport_Code)) AS passengers_out
FROM 
    dwh_detailed.Link_Flights_Airports lfa
INNER JOIN 
    dwh_detailed.Hub_Airports a1 ON lfa.Arrival_Airport_HK = a1.Airport_HK
INNER JOIN 
    dwh_detailed.Hub_Airports a2 ON lfa.Departure_Airport_HK = a2.Airport_HK
INNER JOIN 
    dwh_detailed.Sat_Flights f ON lfa.Flight_HK = f.Flight_HK
LEFT JOIN 
    dwh_detailed.Link_Tickets_Flights ltf ON f.Flight_HK = ltf.Flight_HK
GROUP BY 
    LEAST(a1.Airport_Code, a2.Airport_Code), GREATEST(a1.Airport_Code, a2.Airport_Code)
;