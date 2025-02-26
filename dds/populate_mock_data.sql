-- Insert mock data into Hub_Airports
INSERT INTO dwh_detailed.Hub_Airports (Airport_HK, Airport_Code, Load_DTS, Record_Source) VALUES
(md5('JFK')::UUID, 'JFK', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('LAX')::UUID, 'LAX', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('ORD')::UUID, 'ORD', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('ATL')::UUID, 'ATL', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('DFW')::UUID, 'DFW', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Hub_Aircrafts
INSERT INTO dwh_detailed.Hub_Aircrafts (Aircraft_HK, Aircraft_Code, Load_DTS, Record_Source) VALUES
(md5('A32')::UUID, 'A32', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B73')::UUID, 'B73', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('A38')::UUID, 'A38', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B74')::UUID, 'B74', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B77')::UUID, 'B77', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Hub_Flights
INSERT INTO dwh_detailed.Hub_Flights (Flight_HK, Flight_ID, Load_DTS, Record_Source) VALUES
(md5('AA101')::UUID, 1, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA102')::UUID, 2, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA103')::UUID, 3, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA104')::UUID, 4, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA105')::UUID, 5, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Hub_Bookings
INSERT INTO dwh_detailed.Hub_Bookings (Booking_HK, Book_Ref, Load_DTS, Record_Source) VALUES
(md5('B001')::UUID, 'B001', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B002')::UUID, 'B002', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B003')::UUID, 'B003', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B004')::UUID, 'B004', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('B005')::UUID, 'B005', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Hub_Tickets
INSERT INTO dwh_detailed.Hub_Tickets (Ticket_HK, Ticket_No, Load_DTS, Record_Source) VALUES
(md5('TICKET001')::UUID, 'TICKET001', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET002')::UUID, 'TICKET002', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET003')::UUID, 'TICKET003', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET004')::UUID, 'TICKET004', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET005')::UUID, 'TICKET005', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Link_Flights_Airports
INSERT INTO dwh_detailed.Link_Flights_Airports (Flights_Airports_HK, Flight_HK, Departure_Airport_HK, Arrival_Airport_HK, Load_DTS, Record_Source) VALUES
(md5('AA101' || '+' || 'JFK' || '+' || 'LAX')::UUID, md5('AA101')::UUID, md5('JFK')::UUID, md5('LAX')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA102' || '+' || 'LAX' || '+' || 'ORD')::UUID, md5('AA102')::UUID, md5('LAX')::UUID, md5('ORD')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA103' || '+' || 'ORD' || '+' || 'ATL')::UUID, md5('AA103')::UUID, md5('ORD')::UUID, md5('ATL')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA104' || '+' || 'ATL' || '+' || 'DFW')::UUID, md5('AA104')::UUID, md5('ATL')::UUID, md5('DFW')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('AA105' || '+' || 'DFW' || '+' || 'JFK')::UUID, md5('AA105')::UUID, md5('DFW')::UUID, md5('JFK')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Link_Tickets_Bookings
INSERT INTO dwh_detailed.Link_Tickets_Bookings (Tickets_Bookings_HK, Ticket_HK, Booking_HK, Load_DTS, Record_Source) VALUES
(md5('TICKET001' || '+' || 'B001')::UUID, md5('TICKET001')::UUID, md5('B001')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET002' || '+' || 'B002')::UUID, md5('TICKET002')::UUID, md5('B002')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET003' || '+' || 'B003')::UUID, md5('TICKET003')::UUID, md5('B003')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET004' || '+' || 'B004')::UUID, md5('TICKET004')::UUID, md5('B004')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET005' || '+' || 'B005')::UUID, md5('TICKET005')::UUID, md5('B005')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Link_Tickets_Flights
INSERT INTO dwh_detailed.Link_Tickets_Flights (Tickets_Flights_HK, Ticket_HK, Flight_HK, Load_DTS, Record_Source) VALUES
(md5('TICKET001' || '+' || 'AA101')::UUID, md5('TICKET001')::UUID, md5('AA101')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET002' || '+' || 'AA102')::UUID, md5('TICKET002')::UUID, md5('AA102')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET003' || '+' || 'AA103')::UUID, md5('TICKET003')::UUID, md5('AA103')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET004' || '+' || 'AA104')::UUID, md5('TICKET004')::UUID, md5('AA104')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master'),
(md5('TICKET005' || '+' || 'AA105')::UUID, md5('TICKET005')::UUID, md5('AA105')::UUID, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master');

-- Insert mock data into Sat_Airports
INSERT INTO dwh_detailed.Sat_Airports (Airport_HK, Airport_Code, Airport_Name, City, Coordinates_Lon, Coordinates_Lat, Timezone, Load_DTS, Record_Source, Effective_From, Effective_To) VALUES
(md5('JFK')::UUID, 'JFK', 'John F. Kennedy International Airport', 'New York', -73.7781, 40.6413, 'America/New_York', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('LAX')::UUID, 'LAX', 'Los Angeles International Airport', 'Los Angeles', -118.4085, 33.9425, 'America/Los_Angeles', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('ORD')::UUID, 'ORD', 'Hare International Airport', 'Chicago', -87.9048, 41.9742, 'America/Chicago', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('ATL')::UUID, 'ATL', 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta', -84.4279, 33.6407, 'America/New_York', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('DFW')::UUID, 'DFW', 'Dallas/Fort Worth International Airport', 'Dallas', -97.0379, 32.8968, 'America/Chicago', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP);

-- Insert mock data into Sat_Aircrafts
INSERT INTO dwh_detailed.Sat_Aircrafts (Aircraft_HK, Aircraft_Code, Model, Range, Load_DTS, Record_Source, Effective_From, Effective_To) VALUES
(md5('A32')::UUID, 'A32', '{"manufacturer": "Airbus", "model": "A32", "capacity": 180}', 3000, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B73')::UUID, 'B73', '{"manufacturer": "Boeing", "model": "737", "capacity": 200}', 2900, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('A38')::UUID, 'A38', '{"manufacturer": "Airbus", "model": "A38", "capacity": 500}', 8000, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B74')::UUID, 'B74', '{"manufacturer": "Boeing", "model": "747", "capacity": 400}', 8000, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B77')::UUID, 'B77', '{"manufacturer": "Boeing", "model": "777", "capacity": 300}', 6000, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP);

-- Insert mock data into Sat_Flights
INSERT INTO dwh_detailed.Sat_Flights (Flight_HK, Flight_No, Scheduled_Departure, Scheduled_Arrival, Status, Actual_Departure, Actual_Arrival, Load_DTS, Record_Source, Effective_From, Effective_To) VALUES
(md5('AA101')::UUID, 'AA101', '2023-10-01 10:00:00-04', '2023-10-01 12:00:00-04', 'On Time', '2023-10-01 10:00:00-04', '2023-10-01 12:00:00-04', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('AA102')::UUID, 'AA102', '2023-10-02 14:00:00-04', '2023-10-02 16:00:00-04', 'Delayed', '2023-10-02 15:00:00-04', '2023-10-02 17:00:00-04', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('AA103')::UUID, 'AA103', '2023-10-03 18:00:00-04', '2023-10-03 20:00:00-04', 'Cancelled', NULL, NULL, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('AA104')::UUID, 'AA104', '2023-10-04 22:00:00-04', '2023-10-05 00:00:00-04', 'On Time', '2023-10-04 22:00:00-04', '2023-10-05 00:00:00-04', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('AA105')::UUID, 'AA105', '2023-10-05 08:00:00-04', '2023-10-05 10:00:00-04', 'On Time', '2023-10-05 08:00:00-04', '2023-10-05 10:00:00-04', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP);

-- Insert mock data into Sat_Bookings
INSERT INTO dwh_detailed.Sat_Bookings (Booking_HK, Book_Date, Total_Amount, Load_DTS, Record_Source, Effective_From, Effective_To) VALUES
(md5('B001')::UUID, '2023-09-30 10:00:00-04', 150.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B002')::UUID, '2023-10-01 11:00:00-04', 200.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B003')::UUID, '2023-10-02 12:00:00-04', 300.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B004')::UUID, '2023-10-03 13:00:00-04', 250.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('B005')::UUID, '2023-10-04 14:00:00-04', 350.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP);

-- Insert mock data into Sat_Tickets
INSERT INTO dwh_detailed.Sat_Tickets (Ticket_HK, passenger_id, passenger_name, contact_data, Load_DTS, Record_Source, Effective_From, Effective_To) VALUES
(md5('TICKET001')::UUID, 'P001', 'John Doe', '{"email": "john@example.com", "phone": "123-456-7890"}', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET002')::UUID, 'P002', 'Jane Smith', '{"email": "jane@example.com", "phone": "987-654-3210"}', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET003')::UUID, 'P003', 'Bob Johnson', '{"email": "bob@example.com", "phone": "555-123-4567"}', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET004')::UUID, 'P004', 'Alice Brown', '{"email": "alice@example.com", "phone": "111-222-3333"}', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET005')::UUID, 'P005', 'Mike Davis', '{"email": "mike@example.com", "phone": "444-555-6666"}', '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP);

-- Insert mock data into Sat_Ticket_Flights
INSERT INTO dwh_detailed.Sat_Ticket_Flights (Tickets_Flights_HK, Fare_Conditions, Amount, Load_DTS, Record_Source, Effective_From, Effective_To) VALUES
(md5('TICKET001' || '+' || 'AA101')::UUID, 100.00, 150.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET002' || '+' || 'AA102')::UUID, 150.00, 200.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET003' || '+' || 'AA103')::UUID, 200.00, 300.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET004' || '+' || 'AA104')::UUID, 120.00, 250.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP),
(md5('TICKET005' || '+' || 'AA105')::UUID, 180.00, 350.00, '2024-12-01 00:00:00-04'::TIMESTAMP, 'postgres_master', '2024-12-01 00:00:00-04'::TIMESTAMP, '5999-01-01 00:00:00'::TIMESTAMP);
