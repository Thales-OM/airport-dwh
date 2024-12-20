CREATE TABLE IF NOT EXISTS public.airports
(
    airport_code character(3) NOT NULL,
	airport_name text NOT NULL,
	city text NOT NULL,
	coordinates_lon DOUBLE PRECISION NOT NULL,
	coordinates_lat DOUBLE PRECISION NOT NULL,
	timezone text NOT NULL,
	PRIMARY KEY (airport_code)
);	

ALTER TABLE IF EXISTS public.airports
    OWNER to postgres;
	
	
CREATE TABLE IF NOT EXISTS public.aircrafts
(
    aircraft_code character(3) NOT NULL,
	model jsonb NOT NULL,
	range integer NOT NULL,
	PRIMARY KEY (aircraft_code)
);	
	
ALTER TABLE IF EXISTS public.aircrafts
    OWNER to postgres;
	
	
CREATE TABLE IF NOT EXISTS public.seats
(
    aircraft_code character(3) REFERENCES  aircrafts (aircraft_code) NOT NULL,
	seat_no character VARYING(4) NOT NULL,
	fare_conditions character VARYING(10) NOT NULL,
	PRIMARY KEY (aircraft_code, seat_no)
);	
	
ALTER TABLE IF EXISTS public.seats
    OWNER to postgres;
	
	
CREATE TABLE IF NOT EXISTS public.flights
(
    flight_id serial NOT NULL,
	flight_no character VARYING(6) NOT NULL,
	scheduled_departure timestamptz NOT NULL,
	scheduled_arrival timestamptz NOT NULL,
	departure_airport character(3) REFERENCES  airports (airport_code) NOT NULL,
	arrival_airport character(3) REFERENCES  airports (airport_code) NOT NULL,
	status character VARYING(20) NOT NULL,
	aircraft_code character(3) REFERENCES  aircrafts (aircraft_code) NOT NULL,
	actual_departure timestamptz default Null,
	actual_arrival timestamptz default Null,
	PRIMARY KEY (flight_id)
);	
	
ALTER TABLE IF EXISTS public.flights
    OWNER to postgres;	
	

	
CREATE TABLE IF NOT EXISTS public.bookings
(
    book_ref character(6) NOT NULL,
    book_date timestamptz NOT NULL, 
    total_amount numeric(10,2) NOT NULL,
    PRIMARY KEY (book_ref)
);

ALTER TABLE IF EXISTS public.bookings
    OWNER to postgres;
	
	
	
CREATE TABLE IF NOT EXISTS public.tickets
(
    ticket_no character(13) NOT NULL,
	book_ref CHARACTER(6) REFERENCES  bookings (book_ref) NOT NULL,
	passenger_id character VARYING(20) NOT NULL,
	passanger_name text NOT NULL,
	contact_data jsonb DEFAULT null,
    PRIMARY KEY (ticket_no)
);

ALTER TABLE IF EXISTS public.tickets
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.ticket_flights
(
    ticket_no character(13) REFERENCES  tickets (ticket_no) NOT NULL,
	flight_id INTEGER REFERENCES flights (flight_id) NOT NULL,
	fare_conditions numeric(10,2) NOT NULL,
	amount numeric(10,2) NOT NULL,
    PRIMARY KEY (ticket_no, flight_id)
);	

ALTER TABLE IF EXISTS public.ticket_flights
    OWNER to postgres;
	

CREATE TABLE IF NOT EXISTS public.boarding_passes
(
    ticket_no character(13) NOT NULL,
	flight_id INTEGER NOT NULL,
	boarding_no INTEGER NOT NULL,
	seat_no character VARYING(4) NOT NULL,
    PRIMARY KEY (ticket_no, flight_id),
	CONSTRAINT fk_ticket_flights FOREIGN KEY (ticket_no, flight_id)
		REFERENCES ticket_flights (ticket_no, flight_id)
		ON DELETE CASCADE
);	

ALTER TABLE IF EXISTS public.boarding_passes
    OWNER to postgres;

CREATE OR REPLACE VIEW public.task_view AS
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