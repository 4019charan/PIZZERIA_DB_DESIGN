-- McKinnon Robinson, Charan Basireddy

USE PIZZERIA;


CREATE VIEW ToppingPopularity AS 
select ToppingName Topping, IF(sum(val) > 0, sum(val), 0) ToppingCount from topping
left join (select Pizza_ToppingToppingName, IF(Pizza_ToppingExtra=true, 2, 1) val from pizza_topping) x
on ToppingName=Pizza_ToppingToppingName
group by ToppingName
order by ToppingCount desc;

CREATE VIEW ProfitByPizza AS
SELECT PizzaBaseSize, PizzaBaseCrustType, SUM(PizzaBaseCostC)-SUM(PizzaBaseCostB) Profit, 
DATE_FORMAT(OrderDate, '%Y-%m') Month 
from orders
right join pizza on OrderID=PizzaOrdID
group by PizzaBaseSize, PizzaBaseCrustType
order by Profit desc;

CREATE VIEW ProfitByOrderType AS 
select OrderType customerType, 
	DATE_FORMAT(OrderDate, '%Y-%m') 'Order Month', 
	SUM(OrderCustPrice) 'TotalOrderPrice', 
	SUM(OrderBusinessPrice) 'TotalOrderCost', 
	SUM(OrderCustPrice)-SUM(OrderBusinessPrice) 'Profit'
from orders
group by customerType, DATE_FORMAT(OrderDate, '%Y-%m')
UNION
select NULL, "Grand Total", SUM(OrderCustPrice), SUM(OrderBusinessPrice), SUM(OrderCustPrice)-SUM(OrderBusinessPrice)
from orders;

select * from ToppingPopularity;

select * from ProfitByPizza;

select * from ProfitByOrderType;