-- Total Orders
SELECT
  COUNT(DISTINCT order_id) AS total_orders
FROM
  luisalva.north_wind_traders.orders;


-- Total Sales
SELECT
  ROUND(SUM((od.unit_price * od.quantity)), 2) AS sales_total
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.order_details od
ON
  o.order_id = od.order_id;


-- Total Customers
SELECT
  COUNT(DISTINCT customer_id) AS total_customers
FROM
  luisalva.north_wind_traders.customers;


-- Orders per Month 
SELECT
  EXTRACT(YEAR_MONTH FROM order_date) AS order_month,
  COUNT(order_id) order_count
FROM
  luisalva.north_wind_traders.orders
GROUP BY
  order_month
ORDER BY
  order_month DESC;


-- Sales per Month
SELECT
  EXTRACT(YEAR_MONTH FROM o.order_date) AS order_month,
  ROUND(SUM(od.unit_price * od.quantity), 2) AS total_sales
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.order_details od
ON
  o.order_id = od.order_id
GROUP BY
  order_month
ORDER BY
  order_month DESC;


-- How many customers have order so far?
SELECT
  COUNT(DISTINCT customer_id) AS total_customers
FROM
  luisalva.north_wind_traders.orders

  
-- Orders by Customer. 
SELECT
  c.company_name,
  COUNT(o.order_id) AS order_count
FROM
  luisalva.north_wind_traders.customers c
JOIN
  luisalva.north_wind_traders.orders o
ON
  c.customer_id = o.customer_id
GROUP BY
  c.company_name
ORDER BY
  order_count DESC 


-- Sales by Customer.
SELECT
  c.company_name,
  ROUND(SUM(od.unit_price * od.quantity), 2) AS total_spend
FROM
  luisalva.north_wind_traders.customers c
JOIN
  luisalva.north_wind_traders.orders o
ON
  o.customer_id = c.customer_id
JOIN
  luisalva.north_wind_traders.order_details od
ON
  od.order_id = o.order_id
GROUP BY
  c.company_name
ORDER BY
  total_spend DESC

  
-- Cost per Order. 
SELECT
  c.company_name,
  o.order_id,
  ROUND(SUM(od.unit_price * od.quantity), 2) AS order_total_cost
FROM
  luisalva.north_wind_traders.customers c
JOIN
  luisalva.north_wind_traders.orders o
ON
  o.customer_id = c.customer_id
JOIN
  luisalva.north_wind_traders.order_details od
ON
  od.order_id = o.order_id
GROUP BY
  o.order_id,
  c.company_name
ORDER BY
  order_total_cost DESC

  
--Top 5 selling products by quantity.
SELECT
  p.product_name,
  SUM(od.quantity) AS units_sold
FROM
  luisalva.north_wind_traders.products p
JOIN
  luisalva.north_wind_traders.order_details od
ON
  p.product_id = od.product_id
GROUP BY
  p.product_name
ORDER BY
  units_sold DESC
LIMIT
  5;


-- Top 5 products that bring the most revenue.
SELECT
  p.product_name,
  ROUND(SUM(p.unit_price * od.quantity), 2) AS product_cost
FROM
  luisalva.north_wind_traders.products p
JOIN
  luisalva.north_wind_traders.order_details od
ON
  p.product_id = od.product_id
GROUP BY
  p.product_name
ORDER BY
  product_cost DESC
LIMIT
  5;


-- Total products sold by category
SELECT
  c.category_name,
  SUM(od.quantity) AS sold_count
FROM
  luisalva.north_wind_traders.categories c
JOIN
  luisalva.north_wind_traders.products p
ON
  c.category_id = p.category_id
JOIN
  luisalva.north_wind_traders.order_details od
ON
  p.product_id = od.product_id
GROUP BY
  c.category_name
ORDER BY 
  sold_count DESC;


-- Countries North Wind Traders deleivers to.
SELECT
  COUNT(DISTINCT c.country) AS country_count
FROM
  luisalva.north_wind_traders.customers c
JOIN
  luisalva.north_wind_traders.orders o
ON
  c.customer_id = o.customer_id;


-- Orders per country.
SELECT
  c.country,
  COUNT(c.country) AS order_count
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.customers c
ON
  o.customer_id = c.customer_id
GROUP BY
  c.country
ORDER BY
  order_count DESC; 


-- Sales per country.
SELECT
  c.country,
  ROUND((od.unit_price * od.quantity), 2) AS sales_total
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.order_details od
ON
  o.order_id = od.order_id
JOIN
  luisalva.north_wind_traders.customers c
ON
  o.customer_id = c.customer_id
ORDER BY
  sales_total DESC;


-- Percentage of discounted orders
SELECT
  (
  SELECT
    COUNT(*)
  FROM
    luisalva.north_wind_traders.order_details) AS total_orders,
  (
  SELECT
    COUNT(*)
  FROM
    luisalva.north_wind_traders.order_details
  WHERE
    discount > 0) AS discounted_orders,
  ROUND(((
      SELECT
        COUNT(*)
      FROM
        luisalva.north_wind_traders.order_details
      WHERE
        discount > 0)/ (
      SELECT
        COUNT(*)
      FROM
        luisalva.north_wind_traders.order_details)) * 100, 2) AS percentage_discounted;


-- What is the amount the North Wind Tarders has discounted so far?
SELECT
  ROUND(SUM((unit_price * discount)), 2) AS total_discounted
FROM
  luisalva.north_wind_traders.order_details
WHERE
  discount > 0;


-- What customer has received the most discount so far?
SELECT
  c.company_name,
  ROUND(SUM((od.unit_price * od.discount)), 2) AS total_discounted
FROM
  luisalva.north_wind_traders.customers c
JOIN
  luisalva.north_wind_traders.orders o
ON
  c.customer_id = o.customer_id
JOIN
  luisalva.north_wind_traders.order_details od
ON
  o.order_id = od.order_id
GROUP BY
  c.company_name
ORDER BY
  total_discounted DESC
LIMIT
  1;


-- Total Freight Cost
SELECT
  ROUND(SUM(freight), 2) AS total_freight
FROM
  luisalva.north_wind_traders.orders;


-- Average transportation cost.
SELECT
  ROUND(SUM(freight)/COUNT(order_id), 2) AS average_cost
FROM
  luisalva.north_wind_traders.orders;


-- Transportation provider with most orders delivered.
SELECT
  s.company_name,
  COUNT(o.order_id) AS order_count
FROM
  luisalva.north_wind_traders.shippers s
JOIN
  luisalva.north_wind_traders.orders o
ON
  s.shipper_id = o.shipper_id
GROUP BY
  s.company_name
ORDER BY
  order_count DESC;
 

-- Freight total by transportation provider.
SELECT
  s.company_name,
  ROUND(SUM(o.freight), 2) AS total_freight
FROM
  luisalva.north_wind_traders.shippers s
JOIN
  luisalva.north_wind_traders.orders o
ON
  s.shipper_id = o.shipper_id
GROUP BY
  s.company_name
ORDER BY
  total_freight DESC;


-- Freight total by customer.
SELECT
  c.company_name,
  ROUND(SUM(o.freight), 2) AS total_freight
FROM
  luisalva.north_wind_traders.customers c
JOIN
  luisalva.north_wind_traders.orders o
ON
  c.customer_id = o.customer_id
GROUP BY
  c.company_name
ORDER BY
  total_freight DESC;


average shipping cost
average order
average sale
