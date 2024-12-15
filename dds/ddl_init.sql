-- Hub для аэропортов
CREATE TABLE IF NOT EXISTS Hub_Airports (
    Airport_HK UUID PRIMARY KEY,                -- Хэш-ключ для уникальности
    Airport_Code CHAR(3) NOT NULL,              -- Бизнес-ключ (natural key)
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Hub для самолетов
CREATE TABLE IF NOT EXISTS Hub_Aircrafts (
    Aircraft_HK UUID PRIMARY KEY,               -- Хэш-ключ для уникальности
    Aircraft_Code CHAR(3) NOT NULL,             -- Бизнес-ключ (natural key)
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Hub для рейсов
CREATE TABLE IF NOT EXISTS Hub_Flights (
    Flight_HK UUID PRIMARY KEY,                 -- Хэш-ключ для уникальности
    Flight_ID INT NOT NULL,                     -- Бизнес-ключ
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Hub для бронирований
CREATE TABLE IF NOT EXISTS Hub_Bookings (
    Booking_HK UUID PRIMARY KEY,                -- Хэш-ключ для уникальности
    Book_Ref CHAR(6) NOT NULL,                  -- Бизнес-ключ
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Link для рейсов и аэропортов
CREATE TABLE IF NOT EXISTS Link_Flights_Airports (
    Flights_Airports_HK UUID PRIMARY KEY,       -- Хэш-ключ
    Flight_HK UUID NOT NULL,                    -- Ссылка на Hub_Flights
    Departure_Airport_HK UUID NOT NULL,         -- Ссылка на Hub_Airports
    Arrival_Airport_HK UUID NOT NULL,           -- Ссылка на Hub_Airports
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Link для билетов и бронирований
CREATE TABLE IF NOT EXISTS Link_Tickets_Bookings (
    Tickets_Bookings_HK UUID PRIMARY KEY,       -- Хэш-ключ
    Ticket_No CHAR(13) NOT NULL,                -- Номер билета
    Booking_HK UUID NOT NULL,                   -- Ссылка на Hub_Bookings
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Link для билетов и рейсов
CREATE TABLE IF NOT EXISTS Link_Tickets_Flights (
    Tickets_Flights_HK UUID PRIMARY KEY,        -- Хэш-ключ
    Ticket_HK UUID NOT NULL,                    -- Ссылка на Hub_Tickets
    Flight_HK UUID NOT NULL,                    -- Ссылка на Hub_Flights
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL         -- Источник данных
);

-- Сателлит для аэропортов
CREATE TABLE IF NOT EXISTS Sat_Airports (
    Airport_HK UUID NOT NULL,                   -- Ссылка на Hub_Airports
    Airport_Name TEXT NOT NULL,
    City TEXT NOT NULL,
    Coordinates_Lon DOUBLE PRECISION NOT NULL,
    Coordinates_Lat DOUBLE PRECISION NOT NULL,
    Timezone TEXT NOT NULL,
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL,        -- Источник данных
    Effective_From TIMESTAMP WITH TIME ZONE NOT NULL,
    Effective_To TIMESTAMP WITH TIME ZONE
);

-- Сателлит для самолетов
CREATE TABLE IF NOT EXISTS Sat_Aircrafts (
    Aircraft_HK UUID NOT NULL,                  -- Ссылка на Hub_Aircrafts
    Model JSONB NOT NULL,
    Range INT NOT NULL,
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL,        -- Источник данных
    Effective_From TIMESTAMP WITH TIME ZONE NOT NULL,
    Effective_To TIMESTAMP WITH TIME ZONE
);

-- Сателлит для рейсов
CREATE TABLE IF NOT EXISTS Sat_Flights (
    Flight_HK UUID NOT NULL,                    -- Ссылка на Hub_Flights
    Flight_No CHAR(6) NOT NULL,
    Scheduled_Departure TIMESTAMP WITH TIME ZONE NOT NULL,
    Scheduled_Arrival TIMESTAMP WITH TIME ZONE NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Actual_Departure TIMESTAMP WITH TIME ZONE,
    Actual_Arrival TIMESTAMP WITH TIME ZONE,
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL,        -- Источник данных
    Effective_From TIMESTAMP WITH TIME ZONE NOT NULL,
    Effective_To TIMESTAMP WITH TIME ZONE
);

-- Сателлит для бронирований
CREATE TABLE IF NOT EXISTS Sat_Bookings (
    Booking_HK UUID NOT NULL,                   -- Ссылка на Hub_Bookings
    Book_Date TIMESTAMP WITH TIME ZONE NOT NULL,
    Total_Amount NUMERIC(10, 2) NOT NULL,
    Load_DTS TIMESTAMP WITH TIME ZONE NOT NULL, -- Временная метка загрузки
    Record_Source VARCHAR(50) NOT NULL,        -- Источник данных
    Effective_From TIMESTAMP WITH TIME ZONE NOT NULL,
    Effective_To TIMESTAMP WITH TIME ZONE
);