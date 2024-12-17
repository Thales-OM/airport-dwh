-- Create user for connector (debezium)
CREATE ROLE kafka_replica WITH superuser login PASSWORD 'kafka_replica';

-- Create heartbeat table for health check
CREATE SCHEMA debezium_info;
CREATE TABLE IF NOT EXISTS debezium_info.heartbeat (id serial PRIMARY KEY, date_load TIMESTAMPTZ DEFAULT NOW() );

-- Publication for connector (debezium) to get data from heartbeat and source tables
CREATE PUBLICATION dbz_publication 
FOR TABLE debezium_info.heartbeat,public.*;