create database Flights;

use Flights;

-- For airlines_flights_data.csv
CREATE TABLE airlines_flights_data (
    id INT PRIMARY KEY,
    airline TEXT,
    flight TEXT,
    source_city TEXT,
    departure_time TEXT,
    stops TEXT,
    arrival_time TEXT,
    destination_city TEXT,
    class TEXT,
    duration TEXT,
    days_left INT,
    price NUMERIC
);

-- For flights.csv
CREATE TABLE flights (
    id INT PRIMARY KEY,
    airline TEXT,
    date_of_journey DATE,
    source TEXT,
    destination TEXT,
    dep_time TEXT,
    duration TEXT,
    total_stops TEXT,
    additional_info TEXT,
    price NUMERIC
);


#1. View a sample of flights
SELECT * 
FROM airlines_flights_data 
LIMIT 10;


#2. Count total flights
SELECT COUNT(*) AS total_flights
FROM airlines_flights_data;


#3. Flight Occupancy Rate
SELECT 
    flight,
    source_city,
    destination_city,
    AVG(price) AS avg_price,
    COUNT(*) AS total_tickets
FROM
    airlines_flights_data
GROUP BY flight , source_city , destination_city
ORDER BY total_tickets DESC
LIMIT 10;


#4. Most Profitable Routes (total revenue per route)
SELECT source_city, destination_city, SUM(price) AS total_revenue
FROM airlines_flights_data
GROUP BY source_city, destination_city
ORDER BY total_revenue DESC
LIMIT 10;


#5. Most Expensive Airlines
SELECT airline, ROUND(AVG(price),2) AS avg_price
FROM airlines_flights_data
GROUP BY airline
ORDER BY avg_price DESC
LIMIT 10;


#6. Cheapest Airlines
SELECT 
    airline, ROUND(AVG(price), 2) AS avg_price
FROM
    airlines_flights_data
GROUP BY airline
ORDER BY avg_price ASC
LIMIT 10;


#7. Flight Duration Analysis
SELECT 
    flight, source_city, destination_city, duration, price
FROM
    airlines_flights_data
ORDER BY price DESC
LIMIT 10;


#8. Average Price by Class (Economy vs Business)
SELECT class, ROUND(AVG(price),2) AS avg_price
FROM airlines_flights_data
GROUP BY class;


#9. Most Popular Routes
SELECT source_city, destination_city, COUNT(*) AS total_flights
FROM airlines_flights_data
GROUP BY source_city, destination_city
ORDER BY total_flights DESC
LIMIT 10;


#10. Price Trends by Days Left
SELECT days_left, ROUND(AVG(price),2) AS avg_price
FROM airlines_flights_data
GROUP BY days_left
ORDER BY days_left ASC;


#11.Compare Scheduled vs Actual Average Price
SELECT a.airline,
       ROUND(AVG(a.price),2) AS avg_schedule_price,
       ROUND(AVG(f.Price),2) AS avg_actual_price
FROM airlines_flights_data a
JOIN flights f 
     ON a.airline = f.Airline
    AND a.source_city = f.Source
    AND a.destination_city = f.Destination
GROUP BY a.airline
ORDER BY avg_actual_price DESC;


#12. Most Expensive Routes
SELECT f.Source, f.Destination, ROUND(AVG(f.Price),2) AS avg_price
FROM flights f
GROUP BY f.Source, f.Destination
ORDER BY avg_price DESC
LIMIT 10;


#13.Price Trends by Stops
SELECT Total_Stops, ROUND(AVG(Price),2) AS avg_price
FROM flights
GROUP BY Total_Stops
ORDER BY avg_price ASC;


#14.Advance Booking vs Actual Journey Price
SELECT a.airline, a.days_left,
       ROUND(AVG(a.price),2) AS scheduled_price,
       ROUND(AVG(f.Price),2) AS actual_price
FROM airlines_flights_data a
JOIN flights f 
     ON a.airline = f.Airline
    AND a.source_city = f.Source
    AND a.destination_city = f.Destination
GROUP BY a.airline, a.days_left
ORDER BY a.days_left ASC;







