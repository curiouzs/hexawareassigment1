-- Creating the Digital Asset Management database
CREATE database DigitalAssetManagement;
use DigitalAssetManagement;

-- Table for storing employee information
create table employees(
	employee_id INT PRIMARY KEY,
	name varchar(100),
	department varchar(30),
	email varchar(50),
	password varchar(50), 
)

-- Table for storing asset information
CREATE TABLE assets (
    asset_id INT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    serial_number VARCHAR(100) UNIQUE,
    purchase_date DATE,
    location VARCHAR(100),
    status VARCHAR(50),
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES employees(employee_id)
);

-- Table for maintaining records of asset maintenance
create table maintenance_records(
	maintenance_id  INT PRIMARY KEY,
	asset_id INT, 
	maintenance_date DATE, 
	description varchar(255),
	cost INT,
	FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
)

-- Table for asset allocations to employees
create table asset_allocations(
	allocation_id INT Primary Key,
	asset_id INT,
    employee_id INT,
	FOREIGN KEY (asset_id) REFERENCES assets(asset_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
	allocation_date Date,
	return_date DATE NULL,
)

-- Table for reservations of assets
create table reservations(
	reservation_id INT Primary Key,
	asset_id int,
	employee_id int,
	reservation_date Date,
	start_date Date,
	end_date Date,
	status varchar(100),
	foreign key(employee_id) references employees(employee_id),
	foreign key(asset_id) references assets(asset_id)
)

-- Inserting sample data into the employees table
INSERT INTO employees (employee_id, name, department, email, password) VALUES
(1, 'Rahul Sharma', 'IT', 'rahul.sharma@example.com', 'password123'),
(2, 'Anita Desai', 'HR', 'anita.desai@example.com', 'securePass456'),
(3, 'Vikram Rao', 'Finance', 'vikram.rao@example.com', 'fin1234secure'),
(4, 'Priya Singh', 'Marketing', 'priya.singh@example.com', 'marketPass789'),
(5, 'Amit Kumar', 'Operations', 'amit.kumar@example.com', 'opPass321');

-- Inserting sample data into the assets table
INSERT INTO assets (asset_id, name, type, serial_number, purchase_date, location, status, owner_id) VALUES
(1, 'Dell Laptop', 'Electronics', 'SN12345', '2023-01-15', 'Mumbai', 'Available', 1),
(2, 'Office Chair', 'Furniture', 'SN54321', '2023-02-10', 'Delhi', 'In Use', 2),
(3, 'Projector', 'Electronics', 'SN67890', '2022-11-05', 'Bangalore', 'Available', 3),
(4, 'Smartphone', 'Electronics', 'SN09876', '2023-03-20', 'Chennai', 'In Use', 4),
(5, 'Desk', 'Furniture', 'SN11223', '2022-05-25', 'Kolkata', 'Available', 5);

-- Inserting sample data into the maintenance_records table
INSERT INTO maintenance_records (maintenance_id, asset_id, maintenance_date, description, cost) VALUES
(1, 1, '2023-07-10', 'Battery replacement', 5000),
(2, 2, '2023-08-15', 'Chair repair', 1500),
(3, 3, '2023-06-20', 'Bulb replacement', 2000),
(4, 4, '2023-09-05', 'Screen repair', 3000),
(5, 5, '2023-04-12', 'Polishing', 800);

-- Inserting sample data into the asset_allocations table
INSERT INTO asset_allocations (allocation_id, asset_id, employee_id, allocation_date, return_date) VALUES
(1, 1, 1, '2023-01-16', NULL),
(2, 2, 2, '2023-02-11', '2023-05-11'),
(3, 3, 3, '2023-03-21', NULL),
(4, 4, 4, '2023-03-21', '2023-06-21'),
(5, 5, 5, '2023-05-26', NULL);

-- Inserting sample data into the reservations table
INSERT INTO reservations (reservation_id, asset_id, employee_id, reservation_date, start_date, end_date, status) VALUES
(1, 1, 1, '2023-01-10', '2023-01-15', '2023-01-20', 'Confirmed'),
(2, 3, 3, '2023-03-10', '2023-03-15', '2023-03-20', 'Pending'),
(3, 4, 4, '2023-04-01', '2023-04-05', '2023-04-10', 'Completed'),
(4, 2, 2, '2023-02-05', '2023-02-10', '2023-02-15', 'Cancelled'),
(5, 5, 5, '2023-05-20', '2023-05-25', '2023-05-30', 'Confirmed');

