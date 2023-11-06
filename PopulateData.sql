SET SQL_SAFE_UPDATES = 0;

DELETE FROM Pizza_D;
DELETE FROM Orders;
DELETE FROM Pizza_Topping;
DELETE FROM Delivery;
DELETE FROM DineIn;
DELETE FROM Pickup;
DELETE FROM Pizza; 
DELETE FROM Base; 
DELETE FROM Discount;
DELETE FROM Order_D; 
DELETE FROM Customer;
DELETE FROM Topping;

INSERT INTO 
    Discount
VALUES
    ('Employee',15,NULL),
    ('Lunch Special Medium',NULL,1.00),
    ('Lunch Special Large',NULL,2.00),
    ('Specialty Pizza',NULL,1.50),
    ('Happy Hour',10,NULL),
    ('Gameday Special',20,NULL);

INSERT INTO
    Topping
VALUES
    (
        'Pepperoni',
        0.2,
        1.25,
        100,
        50,
        2,
        2.75,
        3.5,
        4.5
    ),
    (
        'Sausage',
        0.15,
        1.25,
        100,
        50,
        2.5,
        3,
        3.5,
        4.25
    ),
    ('Ham', 0.15, 1.5, 78, 25, 2, 2.5, 3.25, 4),
    ('Chicken', 0.25, 1.75, 56, 25, 1.5, 2, 2.25, 3),
    (
        'Green Pepper',
        0.02,
        0.5,
        79,
        25,
        1,
        1.5,
        2,
        2.5
    ),
    ('Onion', 0.02, 0.5, 85, 25, 1, 1.5, 2, 2.75),
    (
        'Roma Tomato',
        0.03,
        0.75,
        86,
        10,
        2,
        3,
        3.5,
        4.5
    ),
    ('Mushrooms', 0.1, 0.75, 52, 50, 1.5, 2, 2.5, 3),
    (
        'Black Olives',
        0.1,
        0.6,
        39,
        25,
        0.75,
        1,
        1.5,
        2
    ),
    ('Pineapple', 0.25, 1, 15, 0, 1, 1.25, 1.75, 2),
    (
        'Jalapenos',
        0.05,
        0.5,
        64,
        0,
        0.5,
        0.75,
        1.25,
        1.75
    ),
    (
        'Banana Peppers',
        0.05,
        0.5,
        36,
        0,
        0.6,
        1,
        1.3,
        1.75
    ),
    (
        'Regular Cheese',
        0.12,
        0.5,
        250,
        50,
        2,
        3.5,
        5,
        7
    ),
    (
        'Four Cheese Blend',
        0.15,
        1,
        150,
        25,
        2,
        3.5,
        5,
        7
    ),
    ('Feta Cheese', 0.18, 1.5, 75, 0, 1.75, 3, 4, 5.5),
    (
        'Goat Cheese',
        0.2,
        1.5,
        54,
        0,
        1.6,
        2.75,
        4,
        5.5
    ),
    ('Bacon', 0.25, 1.5, 89, 0, 1, 1.5, 2, 3);

INSERT INTO
    Base
VALUES
    ('Small', 'Thin', 3, 0.5),
    ('Small', 'Original', 3, 0.75),
    ('Small', 'Pan', 3.5, 1),
    ('Small', 'Gluten-Free', 4, 2),
    ('Medium', 'Thin', 5, 1),
    ('Medium', 'Original', 5, 1.5),
    ('Medium', 'Pan', 6, 2.25),
    ('Medium', 'Gluten-Free', 6.25, 3),
    ('Large', 'Thin', 8, 1.25),
    ('Large', 'Original', 8, 2),
    ('Large', 'Pan', 9, 3),
    ('Large', 'Gluten-Free', 9.5, 4),
    ('XLarge', 'Thin', 10, 2),
    ('XLarge', 'Original', 10, 3),
    ('XLarge', 'Pan', 11.5, 4.5),
    ('XLarge', 'Gluten-Free', 12.5, 6);

-- order 1
-- todo customer ID 
-- todo remove hard code ids
-- todo discount
INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
VALUES
    (NULL, "2023-03-05 12:03:00", "DINE-IN", 20.75, 3.68, "COMPLETED");

INSERT INTO DineIn (DineInOrderID, DineInTableNum)
SELECT LAST_INSERT_ID(), "21";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT DineInOrderID, "Thin", "Large", "COMPLETED", 3.68, 20.75
FROM DineIn
where DineInTableNum="21";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Pepperoni", false
FROM Pizza
where PizzaBaseCrustType="Thin";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Regular Cheese", true
FROM Pizza
where PizzaBaseCrustType="Thin";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Sausage", false
FROM Pizza
where PizzaBaseCrustType="Thin";

-- order 2
INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
VALUES
    (NULL, "2023-04-03 12:05:00", "DINE-IN", 19.78, 4.63, "COMPLETED");

INSERT INTO DineIn (DineInOrderID, DineInTableNum)
SELECT LAST_INSERT_ID(), "4";

-- first pizza for order 2
INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT DineInOrderID, "Pan", "Medium", "COMPLETED", 3.23, 12.85
FROM DineIn
where DineInTableNum="4";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Feta Cheese", false
FROM Pizza
where PizzaBaseCrustType="Pan";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Black Olives", false
FROM Pizza
where PizzaBaseCrustType="Pan";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Roma Tomato", false
FROM Pizza
where PizzaBaseCrustType="Pan";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Mushrooms", false
FROM Pizza
where PizzaBaseCrustType="Pan";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Banana Peppers", false
FROM Pizza
where PizzaBaseCrustType="Pan";

-- second pizza for order 2
INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT DineInOrderID, "Original", "Small", "COMPLETED", 1.40, 6.93
FROM DineIn
WHERE DineInTableNum="4";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Banana Peppers", false
FROM Pizza
where PizzaBaseCrustType="Original";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Regular Cheese", false
FROM Pizza
where PizzaBaseCrustType="Original";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Chicken", false
FROM Pizza
where PizzaBaseCrustType="Original";

-- andrew customer
INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerPhone)
VALUES ("Andrew", "Wilkes-Krier", "864-254-5861");

-- andrews 6 pizzas
INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
SELECT CustomerID, "2023-03-03 21:30:00", "PICKUP", 14.88*6, 3.30*6, "COMPLETED"
FROM Customer
where CustomerPhone="864-254-5861";

INSERT INTO Pickup
SELECT LAST_INSERT_ID(), CustomerID
FROM Customer
where CustomerPhone="864-254-5861";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "Large", "COMPLETED", 3.30, 14.88
FROM Orders
where OrderDate="2023-03-03 21:30:00";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "Large", "COMPLETED", 3.30, 14.88
FROM Orders
where OrderDate="2023-03-03 21:30:00";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "Large", "COMPLETED", 3.30, 14.88
FROM Orders
where OrderDate="2023-03-03 21:30:00";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "Large", "COMPLETED", 3.30, 14.88
FROM Orders
where OrderDate="2023-03-03 21:30:00";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "Large", "COMPLETED", 3.30, 14.88
FROM Orders
where OrderDate="2023-03-03 21:30:00";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "Large", "COMPLETED", 3.30, 14.88
FROM Orders
where OrderDate="2023-03-03 21:30:00";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Regular Cheese", false
FROM Pizza 
where PizzaBaseCrustType = "Original" and PizzaBaseSize = "Large";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Pepperoni", false
FROM Pizza 
where PizzaBaseCrustType = "Original" and PizzaBaseSize = "Large";

UPDATE Customer
SET CustomerStreet="115 Party Blvd", CustomerCity="Anderson", CustomerState="SC", CustomerZipCode="29621"
where CustomerFirstName="Andrew" and CustomerLastName="Wilkes-Krier";

INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
SELECT CustomerID, "2023-04-20 19:11:00", "PICKUP", 27.94+31.5+26.75, 9.19+6.25+8.18,"COMPLETED"
FROM Customer
where CustomerPhone="864-254-5861";

INSERT INTO Delivery 
SELECT LAST_INSERT_ID(), CustomerID
FROM Customer
where CustomerPhone="864-254-5861";

-- pepperoni + sausage pizza
INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "XLarge", "COMPLETED", 9.19, 27.94
FROM Orders
where OrderDate="2023-04-20 19:11:00";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Pepperoni", false
FROM Pizza 
where PizzaBaseCrustType = "Original" and PizzaBaseSize = "XLarge";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Sausage", false
FROM Pizza 
where PizzaBaseCrustType = "Original" and PizzaBaseSize = "XLarge";

-- pizza 2 ham + pineapple
INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "XLarge", "COMPLETED", 6.25, 31.50
FROM Orders
where OrderDate="2023-04-20 19:11:00";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Ham", true
FROM Pizza 
where PizzaBaseCostB=6.25;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Pineapple", true
FROM Pizza 
where PizzaBaseCostB=6.25;

-- pizza 3 chix + bacon
INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Original", "XLarge", "COMPLETED", 8.18, 26.75
FROM Orders
where OrderDate="2023-04-20 19:11:00";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Bacon", false
FROM Pizza 
where PizzaBaseCostB=8.18;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Chicken", false
FROM Pizza 
where PizzaBaseCostB=8.18;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Four Cheese Blend", false
FROM Pizza 
where PizzaOrdID in (select OrderID from Orders where OrderDate="2023-04-20 19:11:00");

-- matt engers order
INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerPhone)
VALUES ("Matt", "Engers", "864-474-9953");

INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
SELECT CustomerID, "2023-03-02 17:30:00", "PICKUP", 27.45, 7.88,"COMPLETED"
FROM Customer
where CustomerPhone="864-474-9953";

INSERT INTO Pickup
SELECT LAST_INSERT_ID(), CustomerID
FROM Customer
where CustomerPhone="864-474-9953";

-- Pizza with Green Pepper,
-- Onion, Roma Tomatoes, Mushrooms, and Black Olives on it. He wants the Goat Cheese

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Gluten-Free", "XLarge", "COMPLETED", 7.88, 27.45
FROM Orders
where OrderDate="2023-03-02 17:30:00";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Black Olives", false
FROM Pizza 
where PizzaBaseCostB=7.88;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Goat Cheese", false
FROM Pizza 
where PizzaBaseCostB=7.88;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Green Pepper", false
FROM Pizza 
where PizzaBaseCostB=7.88;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Onion", false
FROM Pizza 
where PizzaBaseCostB=7.88;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Roma Tomato", false
FROM Pizza 
where PizzaBaseCostB=7.88;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Mushrooms", false
FROM Pizza 
where PizzaBaseCostB=7.88;

-- frank turner
INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerPhone, CustomerStreet, CustomerState, CustomerCity, CustomerZipCode)
VALUES ("Frank", "Turner", "864-232-8944", "6745 Wessex St", "SC", "Anderson", "29621");

INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
SELECT CustomerID, "2023-03-02 18:17:00", "DELIVERY", 27.45, 7.88,"COMPLETED"
FROM Customer
where CustomerPhone="864-232-8944";

INSERT INTO Delivery
SELECT LAST_INSERT_ID(), CustomerID
FROM Customer
where CustomerPhone="864-232-8944";

-- One large pizza with Chicken, Green
-- Peppers, Onions, and Mushrooms. He wants the Four Cheese Blend (extra) and thin crust 

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Thin", "Large", "COMPLETED", 4.24, 25.81
FROM Orders
where OrderDate="2023-03-02 18:17:00";

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Chicken", false
FROM Pizza 
where PizzaBaseCostB=4.24;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Green Pepper", false
FROM Pizza 
where PizzaBaseCostB=4.24;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Onion", false
FROM Pizza 
where PizzaBaseCostB=4.24;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Mushrooms", false
FROM Pizza 
where PizzaBaseCostB=4.24;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Four Cheese Blend", true
FROM Pizza 
where PizzaBaseCostB=4.24;

-- milo auckerman
INSERT INTO Customer (CustomerFirstName, CustomerLastName, CustomerPhone, CustomerStreet, CustomerState, CustomerCity, CustomerZipCode)
VALUES ("Milo", "Auckerman", "864-878-5679", " 8879 Suburban Home,", "SC", "Anderson", "29621");

INSERT INTO Orders (OrderCustID, OrderDate, OrderType, OrderCustPrice, OrderBusinessPrice, OrderStatus)
SELECT CustomerID, "2023-04-12 20:32:00", "DELIVERY", 18.00+19.25, 2.75+3.25, "COMPLETED"
FROM Customer
where CustomerPhone="864-878-5679";

INSERT INTO Delivery
SELECT LAST_INSERT_ID(), CustomerID
FROM Customer
where CustomerPhone="864-878-5679";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Thin", "Large", "COMPLETED", 2.75, 18.00
FROM Orders
where OrderDate="2023-04-12 20:32:00";

INSERT INTO Pizza (PizzaOrdID, PizzaBaseCrustType, PizzaBaseSize, PizzaBaseStatus, PizzaBaseCostB, PizzaBaseCostC)
SELECT OrderID, "Thin", "Large", "COMPLETED", 3.25, 19.25
FROM Orders
where OrderDate="2023-04-12 20:32:00";

-- one had the Four Cheese
-- Blend on it (extra) (Price: $18.00, Cost: $2.75), the other was Regular Cheese and Pepperoni (extra)

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Four Cheese Blend", true
FROM Pizza 
where PizzaBaseCostB=2.75;

-- pizza 2 
INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Regular Cheese", false 
FROM Pizza 
where PizzaBaseCostB=3.25;

INSERT INTO Pizza_Topping (Pizza_ToppingPizzaID, Pizza_ToppingToppingName, Pizza_ToppingExtra)
SELECT PizzaID, "Pepperoni", false
FROM Pizza 
where PizzaBaseCostB=3.25;