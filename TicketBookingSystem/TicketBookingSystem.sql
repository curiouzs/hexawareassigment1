--Tasks 1: Database Design:
--1. Create the database named "TicketBookingSystem"-- Create the database
CREATE DATABASE TicketBookingSystem;
USE TicketBookingSystem;

--2. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships
-- Create Venue Table
CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- Create Event Table
CREATE TABLE Event (
    event_id INT PRIMARY KEY, 
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT,
	booking_id INT NULL,
    total_seats INT NOT NULL CHECK (total_seats > 0),
    available_seats INT NOT NULL CHECK (available_seats >= 0),
    ticket_price DECIMAL(10, 2) NOT NULL,
    event_type VARCHAR(50) CHECK (event_type IN ('Movie', 'Sports', 'Concert')), 
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
		ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Create Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY, 
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL CHECK (phone_number LIKE '[0-9]%'),
	booking_id INT NULL
);


-- Create Booking Table
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost INT,
    booking_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
		ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id) 
		ON UPDATE CASCADE	
        ON DELETE CASCADE
);

--3. Schema Diagram

-- 4. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
ALTER TABLE Customer 
ADD CONSTRAINT FK_Customer_Booking FOREIGN KEY (booking_id) 
REFERENCES Booking(booking_id)

ALTER TABLE Event 
ADD CONSTRAINT FK_Event_Booking FOREIGN KEY (booking_id) 
REFERENCES Booking(booking_id)

--Tasks 2: Select, Where, Between, AND, LIKE:
--1. Write a SQL query to insert at least 10 sample records into each table.
-- Insert into Venue
INSERT INTO Venue (venue_id, venue_name, address) VALUES 
(1, 'Chennai Stadium', 'Mount Road, Chennai, 600002'),
(2, 'Chennai Concert Hall', 'Pallavaram, Chennai, 600043'),
(3, 'Phoenix Mall Multiplex', 'Velachery, Chennai, 600042'),
(4, 'Express Avenue Theater', 'Royapettah, Chennai, 600014'),
(5, 'Madras Sports Arena', 'Anna Nagar, Chennai, 600040'),
(6, 'Mylapore Auditorium', 'Mylapore, Chennai, 600004'),
(7, 'Chennai Exhibition Center', 'Nungambakkam, Chennai, 600034'),
(8, 'Chennai Indoor Stadium', 'T. Nagar, Chennai, 600017'),
(9, 'Marina Beach Ground', 'Marina Beach, Chennai, 600001'),
(10, 'Chennai Trade Center', 'Nandambakkam, Chennai, 600089');

-- Insert into Event
INSERT INTO Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES 
(1, 'Chennai Super Kings Match', '2024-10-10', '18:00:00', 1, 50000, 20000, 250.00, 'Sports'),
(2, 'AR Rahman Concert', '2024-11-15', '19:00:00', 2, 10000, 5000, 300.00, 'Concert'),
(3, 'Inception Movie', '2024-09-25', '15:00:00', 3, 200, 50, 150.00, 'Movie'),
(4, 'IPL Final Match', '2024-12-01', '17:00:00', 5, 60000, 10000, 500.00, 'Sports'),
(5, 'Kabali Movie', '2024-09-30', '21:00:00', 4, 300, 100, 200.00, 'Movie'),
(6, 'Ed Sheeran Concert', '2024-11-20', '20:00:00', 6, 8000, 4000, 350.00, 'Concert'),
(7, 'Super Singer Live', '2024-10-05', '18:30:00', 7, 5000, 2000, 200.00, 'Concert'),
(8, 'Chennai Marathon', '2024-10-01', '06:00:00', 8, 10000, 7000, 100.00, 'Sports'),
(9, 'Baahubali Movie', '2024-10-05', '15:30:00', 9, 300, 120, 250.00, 'Movie'),
(10, 'Tech Expo 2024', '2024-12-15', '10:00:00', 10, 8000, 3000, 150.00, 'Concert'),
(11, 'Football Cup Finals', '2024-10-26', '17:00:00', 1, 30000, 15000, 400.00, 'Sports'),
(12, 'World Cup', '2024-10-17', '13:00:00', 3, 1500, 244, 1500.00, 'Sports');

-- Insert into Customer
INSERT INTO Customer (customer_id, customer_name, email, phone_number) VALUES
(1, 'Ravi Kumar', 'ravi.kumar@example.com', '9876543210'),
(2, 'Sita Reddy', 'sita.reddy@example.com', '9876543211'),
(3, 'Arun Nair', 'arun.nair@example.com', '9876543212'),
(4, 'Mohan Raj', 'mohan.raj@example.com', '9876543213'),
(5, 'Kavitha Devi', 'kavitha.devi@example.com', '9876543214'),
(6, 'Naveen Iyer', 'naveen.iyer@example.com', '9876543215'),
(7, 'Priya Sharma', 'priya.sharma@example.com', '9876543216'),
(8, 'Vijay Anand', 'vijay.anand@example.com', '9876543217'),
(9, 'Anjali Mehta', 'anjali.mehta@example.com', '9876543218'),
(10, 'Ramesh Gupta', 'ramesh.gupta@example.com', '9876543219'),
(11, 'John Doe', 'john.doe@example.com', '9876540000');

-- Insert into Booking with increased num_tickets (double digits) and total_cost
INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(1, 1, 1, 10, 2500.00, '2024-09-20'),
(2, 2, 2, 12, 3600.00, '2024-09-21'),
(3, 3, 3, 15, 2250.00, '2024-09-22'),
(4, 4, 4, 20, 10000.00, '2024-09-23'),
(5, 5, 5, 25, 5000.00, '2024-10-24'),
(6, 6, 6, 18, 6300.00, '2024-09-25'),
(7, 7, 7, 22, 4400.00, '2024-11-26'),
(8, 8, 8, 11, 1100.00, '2024-12-27'),
(9, 9, 9, 14, 3500.00, '2024-09-28'),
(10, 10, 10, 16, 2400.00, '2025-09-29'),
(11, 1, 3, 13, 1950.00, '2024-10-25'),
(12, 2, 4, 19, 9500.00, '2024-11-26'),
(13, 3, 1, 17, 4250.00, '2024-12-27');

-- putting booking_id from booking table into Customer and event table
UPDATE Event
SET booking_id = b.booking_id
FROM Event e
JOIN Booking b ON e.event_id = b.event_id

UPDATE Customer
SET booking_id = b.booking_id
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id

--2. Write a SQL query to list all Events.
SELECT * FROM Event;

--3. Write a SQL query to select events with available tickets.
SELECT * FROM Event 
WHERE available_seats > 0;

--4. Write a SQL query to select events name partial match with ‘cup’.
SELECT * FROM Event 
WHERE event_name LIKE '%cup%';

--5. Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT * FROM Event 
WHERE ticket_price BETWEEN 1000 AND 2500;

--6. Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM Event 
WHERE event_date BETWEEN '2024-09-01' AND '2024-12-31';

--7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
SELECT * FROM Event 
WHERE available_seats > 0 AND event_name LIKE '%Concert%';

--8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
SELECT * FROM Customer 
ORDER BY customer_id 
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

--9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
SELECT * FROM Booking 
WHERE num_tickets > 4;

--10. Write a SQL query to retrieve customer information whose phone number end with ‘000’
SELECT * FROM Customer 
WHERE phone_number LIKE '%000';

--11. Write a SQL query to retrieve the events in order whose seat capacity more than 15000.
SELECT * FROM Event 
WHERE total_seats > 15000 
ORDER BY total_seats;

--12. Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT * FROM Event 
WHERE event_name NOT LIKE 'x%' 
	AND event_name NOT LIKE 'y%' 
	AND event_name NOT LIKE 'z%';


--Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:
--1. Write a SQL query to List Events and Their Average Ticket Prices.
SELECT event_name, AVG(ticket_price) AS average_ticket_price
FROM Event
GROUP BY event_name;

--2. Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT e.event_name, SUM(b.total_cost) AS total_revenue
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name

--3. Write a SQL query to find the event with the highest ticket sales.
SELECT TOP 1 event_name, SUM(num_tickets) AS total_tickets_sold
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name
ORDER BY total_tickets_sold DESC

--4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
SELECT event_name, SUM(num_tickets) AS total_tickets_sold
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_name
ORDER BY total_tickets_sold DESC;

--5. Write a SQL query to Find Events with No Ticket Sales.
SELECT e.event_name
FROM Event e
LEFT JOIN Booking b ON e.event_id = b.event_id
WHERE b.event_id IS NULL;

--6. Write a SQL query to Find the User Who Has Booked the Most Tickets.
SELECT TOP 1 c.customer_name, SUM(b.num_tickets) AS total_tickets
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_tickets DESC

--7. Write a SQL query to List Events and the total number of tickets sold for each month.
SELECT e.event_name, DATEPART(MONTH, b.booking_date) AS month, SUM(b.num_tickets) AS total_tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name, DATEPART(MONTH, b.booking_date)

--8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
SELECT Venue.venue_name, AVG(Event.ticket_price) AS average_ticket_price
FROM Event
JOIN Venue ON Event.venue_id = Venue.venue_id
GROUP BY Venue.venue_name;

--9. Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type.
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY event_type;

--10. Write a SQL query to calculate the total Revenue Generated by Events in Each Year.
SELECT YEAR(booking_date) AS year, SUM(num_tickets * ticket_price) AS total_revenue
FROM Booking
JOIN Event ON Booking.event_id = Event.event_id
GROUP BY YEAR(booking_date);

--11. Write a SQL query to list users who have booked tickets for multiple events.
SELECT c.customer_name, COUNT(DISTINCT b.event_id) AS eventcount
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT b.event_id) > 1;

--12. Write a SQL query to calculate the Total Revenue Generated by Events for Each User.
SELECT c.customer_name, SUM(b.total_cost) AS total_revenue
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue desc;

--13. Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.
SELECT e.event_type, v.venue_name, AVG(e.ticket_price) AS average_ticket_price
FROM Event e
JOIN Venue v ON e.venue_id = v.venue_id
GROUP BY e.event_type, v.venue_name;

--14. Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days
SELECT c.customer_name, SUM(b.num_tickets) AS puchased_tickets
FROM Booking b
JOIN Customer c ON b.customer_id = c.customer_id
WHERE b.booking_date >= DATEADD(DAY, -30, GETDATE())
GROUP BY c.customer_name;


--Task 4:
-- 1. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT v.venue_name, (SELECT AVG(e.ticket_price) 
		FROM Event e 
        WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venue v;

-- 2. Find Events with More Than 50% of Tickets Sold using subquery
SELECT event_id, event_name
FROM Event e
WHERE available_seats < (SELECT total_seats / 2 FROM Event WHERE event_id = e.event_id);

SELECT e.event_name, 
(SELECT SUM(b.num_tickets) 
FROM Booking b 
WHERE b.event_id = e.event_id) AS total_tickets_sold
FROM Event e;

-- 4. Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery
SELECT *
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM Booking b
    WHERE b.customer_id = c.customer_id
);

-- 5. List Events with No Ticket Sales Using a NOT IN Subquery
SELECT *
FROM Event
WHERE event_id NOT IN (
    SELECT event_id
    FROM Booking
);

-- 6. Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause
SELECT event_type, SUM(total_tickets_sold) AS Tickets_sold
FROM (SELECT e.event_type, SUM(b.num_tickets) AS total_tickets_sold
      FROM Event e
      JOIN Booking b ON e.event_id = b.event_id
      GROUP BY e.event_type) AS subquery
GROUP BY event_type

-- 7. Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause
SELECT *
FROM Event
WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);

-- 8. Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery
SELECT c.customer_id, c.customer_name, 
    (SELECT SUM(num_tickets * e.ticket_price)
     FROM Booking b
     JOIN Event e ON b.event_id = e.event_id
     WHERE b.customer_id = c.customer_id) AS total_revenue
FROM Customer c;

-- 9. List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause
SELECT DISTINCT c.customer_id, c.customer_name
FROM Customer c
WHERE c.customer_id IN (
    SELECT b.customer_id
    FROM Booking b
    JOIN Event e ON b.event_id = e.event_id
    WHERE e.venue_id = 1
);

-- 10. Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY
SELECT event_type, SUM(num_tickets) AS total_tickets_sold
FROM Booking b
JOIN Event e ON b.event_id = e.event_id
GROUP BY event_type;

-- 11. Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT
SELECT DISTINCT c.customer_id, c.customer_name
FROM Customer c
WHERE c.customer_id IN (
    SELECT b.customer_id
    FROM Booking b
    JOIN Event e ON b.event_id = e.event_id
    WHERE MONTH(e.event_date) = 10  -- Replace with the desired month (1-12)
);

-- 12. Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT v.venue_name, (SELECT AVG(e.ticket_price) FROM Event e 
        WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venue v;