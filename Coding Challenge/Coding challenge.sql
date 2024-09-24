--CREATE DATABASE 
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CREATING TABLES
CREATE TABLE Customer(
	customer_id INT PRIMARY KEY, 
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	[password] VARCHAR(100) NOT NULL,
	[address] VARCHAR(255) NOT NULL
)

CREATE TABLE Products(
	product_id INT PRIMARY KEY, 
	[name] VARCHAR(100) NOT NULL,
	[description] VARCHAR(255) NOT NULL,
	price DECIMAL(10,2) , 
	stockqnt INT CHECK (stockqnt >= 0)
)

CREATE TABLE Cart(
	cart_id INT PRIMARY KEY, 
	customer_id INT, 
	product_id INT,
	quantity INT CHECK (quantity >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
	ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    shipping_address VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
	itemAmount DECIMAL(10,2), 
    quantity INT CHECK (quantity >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

--INSERTING VALUES
INSERT INTO Customer (customer_id, first_name, last_name, email, [password], [address]) VALUES
(1, 'John', 'Doe', 'johndoe@example.com', 'password123', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', 'password456', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', 'password789', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', 'password101', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', 'password202', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', 'password303', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', 'password404', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', 'password505', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', 'password606', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', 'password707', '765 Fir St, Territory');

INSERT INTO Customer (customer_id, first_name, last_name, email, [password], [address]) VALUES
(11, 'Lokesh', 'Krishnaa', 'mymail@example.com', 'mypasswordisnull', 'Near Elon Musk SpaceX, Texas');

INSERT INTO Products (product_id, [name], [description], price, stockqnt) VALUES
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

INSERT INTO Orders (order_id, customer_id, order_date, total_price, shipping_address) VALUES
(1, 1, '2023-01-05', 1200.00, '123 Main St, City'),
(2, 2, '2023-02-10', 900.00, '456 Elm St, Town'),
(3, 3, '2023-03-15', 300.00, '789 Oak St, Village'),
(4, 4, '2023-04-20', 150.00, '101 Pine St, Suburb'),
(5, 5, '2023-05-25', 1800.00, '234 Cedar St, District'),
(6, 6, '2023-06-30', 400.00, '567 Birch St, County'),
(7, 7, '2023-07-05', 700.00, '890 Maple St, State'),
(8, 8, '2023-08-10', 160.00, '321 Redwood St, Country'),
(9, 9, '2023-09-15', 140.00, '432 Spruce St, Province'),
(10, 10, '2023-10-20', 1400.00, '765 Fir St, Territory');

INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, itemAmount) VALUES
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 4, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 5, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);

INSERT INTO Cart (cart_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

--SELECTING THE TABLES
SELECT * FROM Customer
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM OrderItems
SELECT * FROM Cart

--------------------------------------------------CODING SOLUTIONS------------------------------------------------
--1. Update refrigerator product price to 800.
UPDATE Products
SET price = 800.00
WHERE name = 'Refrigerator';

--2. Remove all cart items for a specific customer.
DELETE FROM Cart
WHERE customer_id = 7;

--3. Retrieve Products Priced Below $100.
SELECT *
FROM Products
WHERE price < 100;

--4. Find Products with Stock Quantity Greater Than 5.
SELECT * 
FROM Products
WHERE stockqnt > 5;

--5. Retrieve Orders with Total Amount Between $500 and $1000.
SELECT * 
FROM Orders
WHERE total_price BETWEEN 500 AND 1000;

--6. Find Products which name end with letter ‘r’.
SELECT *
FROM Products
WHERE name LIKE '%r';

--7. Retrieve Cart Items for Customer 5.
SELECT *
FROM Cart
WHERE customer_id = 5;

--8. Find Customers Who Placed Orders in 2023.
SELECT c.*
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE YEAR(o.order_date) = 2023;

--9. Determine the Minimum Stock Quantity for Each Product Category.
SELECT [name], MIN(stockqnt) as minimum_qnt 
FROM Products
GROUP BY name;

--10. Calculate the Total Amount Spent by Each Customer.
SELECT c.customer_id, c.first_name, c.last_name, SUM(o.total_price) AS money_spent
FROM Customer c
JOIN Orders o on o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name

--11. Find the Average Order Amount for Each Customer.
SELECT c.customer_id, c.first_name, c.last_name, AVG(o.total_price) AS average_order_amount
FROM Customer c
JOIN Orders o on o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name

--12. Count the Number of Orders Placed by Each Customer.
SELECT o.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS no_of_order
FROM Orders o
JOIN Customer c on c.customer_id = o.customer_id
GROUP BY o.customer_id, c.first_name, c.last_name;

--13. Find the Maximum Order Amount for Each Customer.
SELECT o.customer_id, c.first_name, c.last_name, MAX(total_price) AS max_order_amount
FROM Orders o
JOIN Customer c on c.customer_id = o.customer_id
GROUP BY o.customer_id,  c.first_name, c.last_name;

--14. Get Customers Who Placed Orders Totaling Over $1000.
SELECT o.customer_id, c.first_name, c.last_name, SUM(o.total_price) AS price
FROM Orders o
JOIN Customer c on c.customer_id = o.customer_id
GROUP BY o.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_price) > 1000;

--15. Subquery to Find Products Not in the Cart.
SELECT *
FROM Products
WHERE product_id NOT IN 
	(SELECT product_id FROM Cart);

--16. Subquery to Find Customers Who Haven't Placed Orders.
SELECT *
FROM Customer 
WHERE customer_id NOT IN 
	(SELECT customer_id FROM Orders)

--17. Subquery to Calculate the Percentage of Total Revenue for a Product.
SELECT p.product_id, p.name, 
    (SUM(o.itemAmount) / (SELECT SUM(itemAmount) FROM OrderItems) * 100) 
	AS revenue_percentage
FROM Products p
JOIN OrderItems o ON p.product_id = o.product_id
GROUP BY p.product_id, p.name;

--18. Subquery to Find Products with Low Stock.
-- Here quantity lesser than average is considered as Low Stock
SELECT *
FROM Products
WHERE stockqnt < (SELECT AVG(stockqnt) FROM Products);

--19. Subquery to Find Customers Who Placed High-Value Orders.
-- Here high value orders are which are above $800
SELECT *
FROM Customer c
WHERE c.customer_id IN (SELECT customer_id FROM Orders WHERE total_price > 800);
