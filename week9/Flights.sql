CREATE DATABASE	Flights;

USE Flights;

CREATE TABLE Airline (
	code INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(64) UNIQUE NOT NULL,
	country VARCHAR(128)
)

CREATE TABLE Airport (
	code INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(64) NOT NULL,
	country VARCHAR(128) NOT NULL,
	city VARCHAR(128) NOT NULL

	CONSTRAINT unique_airport_name_country UNIQUE (name, country)
)

CREATE TABLE Airplane (
	code INT PRIMARY KEY IDENTITY(1,1),
	type VARCHAR(64) NOT NULL,
	seats INT NOT NULL CHECK (seats > 0),
	year INT
)

CREATE TABLE Customer (
	id INT PRIMARY KEY IDENTITY(1,1),
	first_name VARCHAR(64),
	last_name VARCHAR(64),
	email VARCHAR(128) NOT NULL

	CONSTRAINT valid_email CHECK (email LIKE '_%@_%._%' AND LEN(email) >= 6)
)

CREATE TABLE Agency (
	name VARCHAR(64) PRIMARY KEY,
	country VARCHAR(128),
	city VARCHAR(128),
	phone_number VARCHAR(16) NOT NULL,
)

CREATE TABLE Flight (
	flight_number INT PRIMARY KEY IDENTITY(1,1),
	airline_code INT NOT NULL FOREIGN KEY REFERENCES Airline(code),
	takeoff_aiport_code INT NOT NULL FOREIGN KEY REFERENCES Airport(code),
	landing_aiport_code INT NOT NULL FOREIGN KEY REFERENCES Airport(code), 
	airplane_code INT NOT NULL FOREIGN KEY REFERENCES Airplane(code),
	takeoff_time DATETIME NOT NULL,
	duration TIME NOT NULL,

	CONSTRAINT FK_Flight_Airline FOREIGN KEY (airline_code)
        REFERENCES Airline(code) ON DELETE CASCADE,

    CONSTRAINT FK_Flight_TakeoffAirport FOREIGN KEY (takeoff_aiport_code)
        REFERENCES Airport(code),

    CONSTRAINT FK_Flight_LandingAirport FOREIGN KEY (landing_aiport_code)
        REFERENCES Airport(code),

    CONSTRAINT FK_Flight_Airplane FOREIGN KEY (airplane_code)
        REFERENCES Airplane(code) ON DELETE CASCADE
)

CREATE TABLE Booking (
	code INT PRIMARY KEY IDENTITY(1,1),
	agency_name VARCHAR(64) NOT NULL FOREIGN KEY REFERENCES Agency(name),
	airline_code INT NOT NULL FOREIGN KEY REFERENCES Airline(code),
	flight_number INT NOT NULL FOREIGN KEY REFERENCES Flight(flight_number),
	customer_id INT NOT NULL FOREIGN KEY REFERENCES Customer(id), 
	reservation_date DATE NOT NULL,
	flight_date DATE NOT NULL,
	price DECIMAL(14,2) NOT NULL,
	approved BIT NOT NULL,

	CONSTRAINT reservation_must_be_before_flight CHECK (reservation_date < flight_date),
	
	CONSTRAINT FK_Booking_Agency
        FOREIGN KEY (agency_name) REFERENCES Agency(name) ON DELETE CASCADE,

    CONSTRAINT FK_Booking_Airline
        FOREIGN KEY (airline_code) REFERENCES Airline(code) ON DELETE CASCADE,

    CONSTRAINT FK_Booking_Flight
        FOREIGN KEY (flight_number) REFERENCES Flight(flight_number),

    CONSTRAINT FK_Booking_Customer
        FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE
	
)