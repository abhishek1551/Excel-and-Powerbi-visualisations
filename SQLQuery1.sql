--getting the total data
select *from dbo.pizza_sales
--average order value
select sum(total_price)/ count(distinct order_id) as Avg_order_value from pizza_sales;

--total pizzas sold
select sum(quantity) as Total_pizzasold from pizza_sales

--total orders
select count(distinct order_id) as total_orders from pizza_sales

--average pizzas per order
--we are using cast function to convert from integer to decimal convention
select cast(cast(sum(quantity) as decimal(10,2))/ 
cast(count(distinct order_id) as decimal(10,2)) as decimal (10,2))as Avg_pizza_perorder from pizza_sales

--daily trend for total orders

select datename(dw,order_date) as order_day, count(distinct order_id)
as Total_orders from pizza_sales
group by datename(dw,order_date) 

--monthly trend for total orders
select datename(month, order_date) as month_name, count(distinct order_id)
as Total_orders from pizza_sales
group by datename(MONTH, order_date)
order by Total_orders desc;

--percentage of sales by pizza category

/*SUM(total_price)- It provides the sum of total_price
for the selected group of rows..
SELECT SUM(total_price)- Displays the sum of the total_price column across all rows. in a table.
It does not group the data or filter the results*/
select pizza_category, sum(total_price) as Total_Sales,sum (total_price)*100/ (select sum(total_price) from pizza_sales where month(order_date)=1) as PCTtotal_indvsales
from pizza_sales 
where month(order_date)=1
group by pizza_category

--percentage of sales by pizza size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Sales,cast(sum (total_price)*100/ (select sum(total_price) from pizza_sales ) as decimal(10,2)) as PCTtotal_indvsales
from pizza_sales 
group by pizza_size

--top 5 best sellers wrt price
select  top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue DESC

--bottom 5 worst sellers wrt price
select  top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue ASC


