CREATE SCHEMA IF NOT EXISTS presentation;

CREATE TABLE IF NOT EXISTS presentation.frequent_flyers (
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,   -- Timestamp of the record creation
    passenger_id character VARYING(20) NOT NULL PRIMARY KEY,  -- Unique identifier for the passenger
    passenger_name TEXT NOT NULL,                   -- Name of the passenger
    flights_number INT NOT NULL,                    -- Total number of flights taken by the passenger
    purchase_sum NUMERIC(10, 2) NOT NULL,           -- Total amount spent by the passenger
    home_airport CHAR(3) NOT NULL,                  -- Code of the home airport
    customer_group VARCHAR(3) NOT NULL              -- Customer group based on spending percentile
);

CREATE TABLE IF NOT EXISTS presentation.airport_traffic (
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,   -- Timestamp of the record creation
    flight_date TIMESTAMP WITH TIME ZONE NOT NULL,
    airport_code CHAR(3) NOT NULL,                   
    linked_airport_code CHAR(3) NOT NULL,                   
    flights_in INT DEFAULT 0,       
    flights_out INT DEFAULT 0,                
    passengers_in INT DEFAULT 0,    
    passengers_out INT DEFAULT 0,

    PRIMARY KEY (airport_code, linked_airport_code, flight_date)  
);