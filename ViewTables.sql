select ToppingName, IF(sum(val) > 0, sum(val), 0) ToppingCount from topping
left join (select Pizza_ToppingToppingName, IF(Pizza_ToppingExtra=true, 2, 1) val from pizza_topping) x
on ToppingName=Pizza_ToppingToppingName
group by ToppingName
order by ToppingCount desc;