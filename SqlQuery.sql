-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- Average Order Value
SELECT 
    CAST(SUM(total_price) * 1.0 / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
    AS Avg_Order_Value
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT 
    CAST(SUM(quantity) AS DECIMAL(10,2)) /
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
    AS Avg_Pizzas_per_Order
FROM pizza_sales;

-- Daily Trend for Total Orders
SELECT 
    DATENAME(WEEKDAY, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date);

-- Hourly Trend for Orders
SELECT 
    DATEPART(HOUR, order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY order_hour;

-- Percent of Sales by Pizza Category
SELECT 
    pizza_category,
    SUM(total_price) AS total_revenue,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS pct
FROM pizza_sales
GROUP BY pizza_category;

-- Percent of Sales by Pizza Size
SELECT 
    pizza_size,
    SUM(total_price) AS total_revenue,
    SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS pct
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- Total Pizzas Sold by Category (February)
SELECT 
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Top 5 Best Sellers by Quantity
SELECT TOP 5 
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC;

-- Bottom 5 Worst Sellers by Quantity
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC;
