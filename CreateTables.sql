DROP SCHEMA IF EXISTS PIZZERIA;

CREATE SCHEMA PIZZERIA;

USE PIZZERIA;

-- Dropping tables if they exist to prevent errors
DROP TABLE IF EXISTS Pizza_D, Orders, Pizza_Topping, Delivery, DineIn, Pickup, Pizza, Base, Discount, Order_D, Customer, Topping;

-- Creating tables

-- Customer Table
CREATE TABLE Customer (
  CustomerID VARCHAR(15) NOT NULL,
  CustomerFirstName VARCHAR(15),
  CustomerLastName VARCHAR(15),
  CustomerPhone VARCHAR(11),
  CustomerStreet VARCHAR(15) NOT NULL,
  CustomerCity VARCHAR(10) NOT NULL,
  CustomerState VARCHAR(5) NOT NULL,
  CustomerZipCode INT NOT NULL,
  PRIMARY KEY (CustomerID)
);

-- Order Table
CREATE TABLE Orders (
  OrderID VARCHAR(15) NOT NULL,
  OrderCustID VARCHAR(15),
  OrderDate TIMESTAMP NOT NULL,
  OrderType VARCHAR(15) NOT NULL,
  OrderCustPrice DECIMAL(5,2) NOT NULL,
  OrderBusinessPrice DECIMAL(5,2) NOT NULL,
  OrderStatus VARCHAR(20) NOT NULL,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (OrderCustID) REFERENCES Customer(CustomerID)
);

-- DineIn Table
CREATE TABLE DineIn (
  DineInOrderID VARCHAR(15) NOT NULL PRIMARY KEY,
  DineInTableNum VARCHAR(15) NOT NULL,
  FOREIGN KEY (DineInOrderID) REFERENCES Orders(OrderID)
);

-- Delivery Table
CREATE TABLE Delivery (
  DeliveryOrderID VARCHAR(15) NOT NULL PRIMARY KEY,
  DeliveryCustomerID VARCHAR(15) NOT NULL,
  FOREIGN KEY (DeliveryCustomerID) REFERENCES Customer(CustomerID)
);

-- PickUp Table
CREATE TABLE Pickup (
  PickupOrderID VARCHAR(15) NOT NULL,
  PickupCustomerID VARCHAR(20) NOT NULL,
  PRIMARY KEY (PickupOrderID),
  FOREIGN KEY (PickupOrderID) REFERENCES Orders(OrderID)
);

-- BasePrice Table
CREATE TABLE Base (
  BaseSize VARCHAR(15) NOT NULL,
  BaseCrustType VARCHAR(15) NOT NULL,
  BasePizzaCostC DECIMAL(5,2) NOT NULL,
  BasePizzaCostB DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (BaseSize, BaseCrustType)
);

-- Pizza Table
CREATE TABLE Pizza (
  PizzaID VARCHAR(15) PRIMARY KEY,
  PizzaOrdID VARCHAR(15) NOT NULL,
  PizzaBaseCrustType VARCHAR(15) NOT NULL,
  PizzaBaseSize VARCHAR(15) NOT NULL,
  PizzaBaseStatus VARCHAR(15) NOT NULL,
  PizzaBaseCostB DECIMAL(5,2) NOT NULL,
  PizzaBaseCostC DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (PizzaBaseSize, PizzaBaseCrustType) REFERENCES Base(BaseSize, BaseCrustType),
  FOREIGN KEY (PizzaOrdID) REFERENCES Orders(OrderID)
);

-- Topping Table
CREATE TABLE Topping (
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
CREATE TABLE Pizza_Topping (
  Pizza_ToppingPizzaID VARCHAR(20) NOT NULL,
  Pizza_ToppingToppingName VARCHAR(20) NOT NULL,
  Pizz_ToppingExtra BOOL,
  PRIMARY KEY (Pizza_ToppingPizzaID, Pizza_ToppingToppingName),
  FOREIGN KEY (Pizza_ToppingPizzaID) REFERENCES Pizza(PizzaID),
  FOREIGN KEY (Pizza_ToppingToppingName) REFERENCES Topping(ToppingName)
);

-- Discount Table
CREATE TABLE Discount (
  DiscountID VARCHAR(10) PRIMARY KEY,
  DiscountPer VARCHAR(25) NOT NULL,
  DiscountDollar DECIMAL(5,2) NOT NULL
  );

-- PizzaDiscount Table
CREATE TABLE Pizza_D (
  Pizza_DDiscountID VARCHAR(10) NOT NULL,
  Pizza_DPizzaID VARCHAR(10) NOT NULL,
  PRIMARY KEY (Pizza_DDiscountID, Pizza_DPizzaID),
  FOREIGN KEY (Pizza_DPizzaID) REFERENCES Pizza(PizzaID),
  FOREIGN KEY (Pizza_DDiscountID) REFERENCES Discount(DiscountID)
);

-- OrderDiscount Table
CREATE TABLE Order_D (
  Order_DDiscountID VARCHAR(10) NOT NULL,
  Order_DOrderID VARCHAR(10) NOT NULL,
  PRIMARY KEY (Order_DDiscountID, Order_DOrderID),
  FOREIGN KEY (Order_DOrderID) REFERENCES Orders(OrderID),
  FOREIGN KEY (Order_DDiscountID) REFERENCES Discount(DiscountID)
);

