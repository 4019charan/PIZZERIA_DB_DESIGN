DROP SCHEMA IF EXISTS PIZZERIA;

CREATE SCHEMA PIZZERIA;

USE PIZZERIA;

-- Dropping tables if they exist to prevent errors
DROP TABLE IF EXISTS pizza_d, orders, pizza_topping, delivery, dinein, pickup, pizza, base, discount, order_d, customer, topping;

-- Creating tables

-- Customer Table
CREATE TABLE customer (
  CustomerID INTEGER NOT NULL AUTO_INCREMENT,
  CustomerFirstName VARCHAR(15),
  CustomerLastName VARCHAR(15),
  CustomerPhone VARCHAR(20),
  CustomerStreet VARCHAR(30) NOT NULL,
  CustomerCity VARCHAR(10) NOT NULL,
  CustomerState VARCHAR(5) NOT NULL,
  CustomerZipCode INT NOT NULL,
  PRIMARY KEY (CustomerID)
);

-- Order Table
CREATE TABLE orders (
  OrderID VARCHAR(15) NOT NULL,
  OrderCustID VARCHAR(15),
  OrderDate TIMESTAMP NOT NULL,
  OrderType VARCHAR(15) NOT NULL,
  OrderCustPrice DECIMAL(5,2) NOT NULL,
  OrderBusinessPrice DECIMAL(5,2) NOT NULL,
  OrderStatus VARCHAR(20) NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (OrderCustID) REFERENCES customer(CustomerID)
);

-- DineIn Table
CREATE TABLE dinein (
  DineInOrderID VARCHAR(15) NOT NULL PRIMARY KEY,
  DineInTableNum VARCHAR(15) NOT NULL,
  FOREIGN KEY (DineInOrderID) REFERENCES orders(OrderID)
);

-- Delivery Table
CREATE TABLE delivery (
  DeliveryOrderID VARCHAR(15) NOT NULL PRIMARY KEY,
  DeliveryCustomerID VARCHAR(15) NOT NULL,
  FOREIGN KEY (DeliveryCustomerID) REFERENCES customer(CustomerID)
);

-- PickUp Table
CREATE TABLE pickup (
  PickupOrderID VARCHAR(15) NOT NULL,
  PickupCustomerID VARCHAR(20) NOT NULL,
  PRIMARY KEY (PickupOrderID),
  FOREIGN KEY (PickupOrderID) REFERENCES orders(OrderID)
);

-- BasePrice Table
CREATE TABLE base (
  BaseSize VARCHAR(15) NOT NULL,
  BaseCrustType VARCHAR(15) NOT NULL,
  BasePizzaCostC DECIMAL(5,2) NOT NULL,
  BasePizzaCostB DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (BaseSize, BaseCrustType)
);

-- Pizza Table
CREATE TABLE pizza (
  PizzaID VARCHAR(15) PRIMARY KEY,
  PizzaOrdID VARCHAR(15) NOT NULL,
  PizzaBaseCrustType VARCHAR(15) NOT NULL,
  PizzaBaseSize VARCHAR(15) NOT NULL,
  PizzaBaseStatus VARCHAR(15) NOT NULL,
  PizzaBaseCostB DECIMAL(5,2) NOT NULL,
  PizzaBaseCostC DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (PizzaBaseSize, PizzaBaseCrustType) REFERENCES base(BaseSize, BaseCrustType),
  FOREIGN KEY (PizzaOrdID) REFERENCES orders(OrderID)
);

-- Topping Table
CREATE TABLE topping (
  ToppingName VARCHAR(20) PRIMARY KEY,
  ToppingCost_B DECIMAL(5,2) NOT NULL,
  ToppingCost_C DECIMAL(5,2) NOT NULL,
  ToppingCurrentInv INT NOT NULL,
  ToppingMinInv INT NOT NULL,
  ToppingAmount_P DECIMAL(5,2) NOT NULL,
  ToppingAmount_M DECIMAL(5,2) NOT NULL,
  ToppingAmount_L DECIMAL(5,2) NOT NULL,
  ToppingAmount_XL DECIMAL(5,2) NOT NULL
);

-- PizzaTopping Table
CREATE TABLE pizza_topping (
  Pizza_ToppingPizzaID VARCHAR(20) NOT NULL,
  Pizza_ToppingToppingName VARCHAR(20) NOT NULL,
  Pizz_ToppingExtra BOOL,
  PRIMARY KEY (Pizza_ToppingPizzaID, Pizza_ToppingToppingName),
  FOREIGN KEY (Pizza_ToppingPizzaID) REFERENCES pizza(PizzaID),
  FOREIGN KEY (Pizza_ToppingToppingName) REFERENCES topping(ToppingName)
);

-- Discount Table
CREATE TABLE discount (
  DiscountID VARCHAR(30) PRIMARY KEY,
  DiscountPer INT,
  DiscountDollar DECIMAL(5,2)
  );

-- PizzaDiscount Table
CREATE TABLE pizza_d (
  Pizza_DDiscountID VARCHAR(10) NOT NULL,
  Pizza_DPizzaID VARCHAR(10) NOT NULL,
  PRIMARY KEY (Pizza_DDiscountID, Pizza_DPizzaID),
  FOREIGN KEY (Pizza_DPizzaID) REFERENCES pizza(PizzaID),
  FOREIGN KEY (Pizza_DDiscountID) REFERENCES discount(DiscountID)
);

-- OrderDiscount Table
CREATE TABLE order_d (
  Order_DDiscountID VARCHAR(10) NOT NULL,
  Order_DOrderID VARCHAR(10) NOT NULL,
  PRIMARY KEY (Order_DDiscountID, Order_DOrderID),
  FOREIGN KEY (Order_DOrderID) REFERENCES orders(OrderID),
  FOREIGN KEY (Order_DDiscountID) REFERENCES discount(DiscountID)
);

