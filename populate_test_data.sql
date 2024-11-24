-- Insert test data into airports
INSERT INTO public.airports (airport_code, airport_name, city, coordinates_lon, coordinates_lat, timezone) VALUES
('JFK', 'John F. Kennedy International Airport', 'New York', -73.7781, 40.6413, 'America/New_York'),
('LAX', 'Los Angeles International Airport', 'Los Angeles', -118.4085, 33.9425, 'America/Los_Angeles'),
('ORD', 'Hare International Airport', 'Chicago', -87.9048, 41.9742, 'America/Chicago'),
('ATL', 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta', -84.4279, 33.6407, 'America/New_York'),
('DFW', 'Dallas/Fort Worth International Airport', 'Dallas', -97.0379, 32.8968, 'America/Chicago');

-- Insert test data into aircrafts
INSERT INTO public.aircrafts (aircraft_code, model, range) VALUES
('A32', '{"manufacturer": "Airbus", "model": "A32", "capacity": 180}', 3000),
('B73', '{"manufacturer": "Boeing", "model": "737", "capacity": 200}', 2900),
('A38', '{"manufacturer": "Airbus", "model": "A38", "capacity": 500}', 8000),
('B74', '{"manufacturer": "Boeing", "model": "747", "capacity": 400}', 8000),
('B77', '{"manufacturer": "Boeing", "model": "777", "capacity": 300}', 6000);

-- Insert test data into seats
INSERT INTO public.seats (aircraft_code, seat_no, fare_conditions) VALUES
('A32', '1A', 'Economy'),
('A32', '1B', 'Economy'),
('B73', '2A', 'Business'),
('B73', '2B', 'Business'),
('A38', '3A', 'First'),
('A38', '3B', 'First'),
('B74', '4A', 'Economy'),
('B77', '5A', 'Economy');

-- Insert test data into flights
INSERT INTO public.flights (flight_no, scheduled_departure, scheduled_arrival, departure_airport, arrival_airport, status, aircraft_code) VALUES
('AA101', '2023-10-01 10:00:00-04', '2023-10-01 12:00:00-04', 'JFK', 'LAX', 'On Time', 'A32'),
('AA102', '2023-10-02 14:00:00-04', '2023-10-02 16:00:00-04', 'LAX', 'ORD', 'Delayed', 'B73'),
('AA103', '2023-10-03 18:00:00-04', '2023-10-03 20:00:00-04', 'ORD', 'ATL', 'Cancelled', 'A38'),
('AA104', '2023-10-04 22:00:00-04', '2023-10-05 00:00:00-04', 'ATL', 'DFW', 'On Time', 'B74'),
('AA105', '2023-10-05 08:00:00-04', '2023-10-05 10:00:00-04', 'DFW', 'JFK', 'On Time', 'B77');

-- Insert test data into bookings
INSERT INTO public.bookings (book_ref, book_date, total_amount) VALUES
('B001', '2023-09-30 10:00:00-04', 150.00),
('B002', '2023-10-01 11:00:00-04', 200.00),
('B003', '2023-10-02 12:00:00-04', 300.00),
('B004', '2023-10-03 13:00:00-04', 250.00),
('B005', '2023-10-04 14:00:00-04', 350.00);

-- Insert test data into tickets
INSERT INTO public.tickets (ticket_no, book_ref, passenger_id, passanger_name, contact_data) VALUES
('TICKET001', 'B001', 'P001', 'John Doe', '{"email": "john@example.com", "phone": "123-456-7890"}'),
('TICKET002', 'B002', 'P002', 'Jane Smith', '{"email": "jane@example.com", "phone": "987-654-3210"}'),
('TICKET003', 'B003', 'P003', 'Bob Johnson', '{"email": "bob@example.com", "phone": "555-123-4567"}'),
('TICKET004', 'B004', 'P004', 'Alice Brown', '{"email": "alice@example.com", "phone": "111-222-3333"}'),
('TICKET005', 'B005', 'P005', 'Mike Davis', '{"email": "mike@example.com", "phone": "444-555-6666"}');

-- Insert test data into ticket_flights
INSERT INTO public.ticket_flights (ticket_no, flight_id, fare_conditions, amount) VALUES
('TICKET001', 1, 100.00, 150.00),
('TICKET002', 2, 150.00, 200.00),
('TICKET003', 3, 200.00, 300.00),
('TICKET004', 4, 120.00, 250.00),
('TICKET005', 5, 180.00, 350.00);

-- Insert test data into boarding_passes
INSERT INTO public.boarding_passes (ticket_no, flight_id, boarding_no, seat_no) VALUES
('TICKET001', 1, 1, '1A'),
('TICKET002', 2, 2, '2A'),
('TICKET003', 3, 3, '3A'),
('TICKET004', 4, 4, '4A'),
('TICKET005', 5, 5, '5A');
