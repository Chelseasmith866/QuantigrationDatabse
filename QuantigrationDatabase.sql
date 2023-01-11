mysql

CREATE DATABASE QuantigrationUpdates;

SHOW DATABASES;

use QuantigrationUpdates;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(25),
LastName VARCHAR(25),
Street VARCHAR(50),
City VARCHAR(50),
State VARCHAR(25),
ZipCode INT,
Telephone VARCHAR(15));

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
SKU VARCHAR(20),
Description VARCHAR(50));

CREATE TABLE RMA (
RMAID INT PRIMARY KEY,
OrderID INT,
Step VARCHAR(50),
Status VARCHAR(15),
Reason VARCHAR(15));

ALTER TABLE Customers RENAME Collaborators;

ALTER TABLE Collaborators CHANGE CustomerID CollaboratorID INT;

ALTER TABLE Orders CHANGE CustomerID CollaboratorID INT;


LOAD DATA INFILE '/home/codio/workspace/customers.csv'
INTO TABLE Collaborators
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE '/home/codio/workspace/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';

LOAD DATA INFILE '/home/codio/workspace/rma.csv'
INTO TABLE RMA
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';

SELECT COUNT(Orders.OrderID) AS FraminghamOrderCount
FROM Collaborators
JOIN Orders
ON Collaborators.CollaboratorID = Orders.CollaboratorID
WHERE Collaborators.City = 'Framingham';

SELECT *
FROM Collaborators
WHERE State = 'Massachusetts';

INSERT INTO Collaborators VALUES
(100004, 'Luke', 'Skywalker', '15 Maiden Lane', 'New York', 'NY', 10222, '212-555-1234'),
(100005, 'Winston', 'Smith', '123 Sycamore Street', 'Greensboro', 'NC', 27401, '919-555-6623'),
(100006, 'MaryAnne', 'Jenkins', '1 Coconut Way', 'Jupiter', 'FL', 33458, '321-555-8907'),
(100007, 'Janet', 'Williams', '555 Redondo Beach Blvd', 'Torrence', 'CA', 90501, '301-555-5678');

INSERT INTO Orders Values
(1204305, 100004, 'ADV-24-10C', 'Advanced Switch 10GigE Copper 24 port'),
(1204306, 100005, 'ADV-48-10F', 'Advanced Switch 10 GigE Copper/Fiber 44 port copper 4 port fiber'),
(1204307, 100006, 'ENT-24-10F', 'Enterprise Switch 10 GigE SFP+ 24 Port'),
(1204308, 100007, 'ENT-48-10F', 'Enterprise Switch 10GigE SFP+ 48 port');

SELECT COUNT(*) AS WoonsocketRecordCount
FROM Collaborators
WHERE City = 'Woonsocket';

SELECT Status, Step
FROM RMA
WHERE OrderID = 5175;

UPDATE RMA
SET Status = 'Complete', Step = 'Credit Customer Account'
WHERE OrderID = 5175;

SELECT Status, Step
FROM RMA
WHERE OrderID = 5175;

DELETE FROM RMA
WHERE Reason = 'Rejected';

SELECT *
FROM Orders
INTO OUTFILE '/home/codio/workspace/QuantigrationOrders.csv'
FIELDS TERMINATED BY ',';
