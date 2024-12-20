-- Create user for connector (debezium)
CREATE ROLE kafka_replica WITH superuser login PASSWORD 'kafka_replica';

-- Create heartbeat table for health check
CREATE SCHEMA IF NOT EXISTS debezium_info;
CREATE TABLE IF NOT EXISTS debezium_info.heartbeat (id serial PRIMARY KEY, date_load TIMESTAMPTZ DEFAULT NOW() );

-- Publication for connector (debezium) to get data from heartbeat and source tables
-- Check if the publication exists and create it if it does not
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'dbz_publication') THEN
        CREATE PUBLICATION dbz_publication 
        FOR TABLE debezium_info.heartbeat, 
        public.airports, 
        public.aircrafts, 
        public.seats, 
        public.flights, 
        public.bookings, 
        public.tickets, 
        public.ticket_flights, 
        public.boarding_passes;
    END IF;
END $$;