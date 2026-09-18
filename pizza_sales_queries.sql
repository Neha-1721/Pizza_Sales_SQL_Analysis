SELECT * FROM pizza_sales;
/* Total Revenue
     Problem:The sum of the total price of all pizza order. */
SELECT SUM(total_price) / COUNT(DISTINCT order_id) as Avg_Order_Value from pizza_sales;

/* Total Revenue
     Problem:The sum of the total price of all pizza order. */
SELECT SUM(total_price) AS Total_Revenue from pizza_sales;

/*Total pizza sold:
      Problem:The sum of quantities of all pizza sold.] */
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales;

/* Total Orders
Problem:The total number of orders placed.*/
SELECT COUNT(DISTINCT order_id) AS Total_orders from pizza_sales;

/* Average pizza order
       Problem:The Average number of pizzas sold per order,calculated by dividing the total number of pizzas sold by the total number of orders*/
SELECT SUM(quantity) / COUNT(DISTINCT order_id) from pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_order from pizza_sales;
/* Daily Trend for Total Orders
       Problem: Calculate daily total orders for trend analysis.*/
SELECT TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'Day') AS order_day, 
       COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales
GROUP BY TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'Day');

/* Monthly Trend for Total Orders 
        Problem: Calculate monthly total orders to track performance over time.*/
SELECT 
    TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'FMMonth') AS Month_Name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'FMMonth')
ORDER BY Total_orders DESC;

/*Percentage of Sales by Pizza Category 
           Problem:Calculate percentage of sales contribution for pizza categories.*/
SELECT 
    pizza_category, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_sales
FROM pizza_sales
WHERE EXTRACT (MONTH FROM TO_DATE(order_date, 'DD-MM-YYYY')) = 1
GROUP BY pizza_category;

/* Percentage of Sales by Pizza Size
    Problem:Generate a chart that represents the percentage of sales attributed to different pizza sizes*/

SELECT 
    pizza_size, 
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_sales
FROM pizza_sales
WHERE EXTRACT (MONTH FROM TO_DATE(order_date, 'DD-MM-YYYY')) = 1
GROUP BY pizza_size
ORDER BY  percentage_sales DESC

SELECT pizza_size, sum(total_price) as Total_Sales, CAST(sum(total_price) * 100 /
(SELECT sum(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
from pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC


 /* Percentage of Sales by Pizza Size
      Problem Statement: Calculate the total sales and percentage contribution to overall sales for each pizza size, specifically filtered for the first quarter*/

SELECT 
    pizza_size, 
    CAST(sum(total_price) AS DECIMAL(10,2)) as Total_Sales, 
    CAST(sum(total_price) * 100 / (
        SELECT sum(total_price) 
        FROM pizza_sales 
        WHERE EXTRACT(QUARTER FROM TO_DATE(order_date, 'DD-MM-YYYY')) = 1
    ) AS DECIMAL(10,2)) AS PCT
from pizza_sales
WHERE EXTRACT(QUARTER FROM TO_DATE(order_date, 'DD-MM-YYYY')) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

/*Top 5 Best Sellers by Revenue 
      Problem Statement: Identify the top 5 highest revenue-generating pizzas*/
SELECT pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;
 /* Bottom 5 Best Sellers by Total Orders 
        Problem Statement:Identify the bottom 5 worst-selling pizzas based on the total number of orders.*/
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;

ALTER USER postgres WITH PASSWORD '1234';



