-- How many orders per month? Months with most orders.
SELECT
  EXTRACT(YEAR_MONTH FROM order_date) AS order_month,
  COUNT(order_id) order_count
FROM
  luisalva.north_wind_traders.orders
GROUP BY
  order_month
ORDER BY
  order_month DESC;


-- What orders haven't shipped yet?
SELECT
  *
FROM
  luisalva.north_wind_traders.orders
WHERE
  shipped_date IS NULL

  
-- Total orders by Company. Top 5 companies with the most orders.
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

  
-- Total cost per order. Top 5 expesive orders.
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

  
-- Total quantity ordered by company(all orders combined). Top 5 companies with most quanitity ordered.
SELECT
  c.company_name,
  sum (od.quantity) AS total_quantity_ordered
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
  total_quantity_ordered DESC

  
-- Total money spent by each company? Top 5 companies with more money spent.
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

  
-- What are the top 5 selling products by quantity?
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


-- What are the top 5 products that bring the most revenue?
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


-- Revenue by year.
SELECT
  EXTRACT(year
  FROM
    o.order_date) AS order_year,
  ROUND(SUM(od.quantity * p.unit_price)) AS revenue
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.order_details od
ON
  o.order_id = od.order_id
JOIN
  luisalva.north_wind_traders.products p
ON
  od.product_id = p.product_id
GROUP BY
  order_year;


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


-- Orders per city.
SELECT
  c.city,
  COUNT(c.city) AS order_count
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.customers c
ON
  o.customer_id = c.customer_id
GROUP BY
  c.city
ORDER BY
  order_count DESC;

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


-- Orders processed by employee.
SELECT
  e.employee_name,
  e.title,
  e.city,
  COUNT(o.order_id) AS order_count
FROM
  luisalva.north_wind_traders.employees e
JOIN
  luisalva.north_wind_traders.orders o
ON
  o.employee_id = e.employee_id
GROUP BY
  e.employee_name,
  e.title,
  e.city
ORDER BY
  order_count DESC;


Shipper with most orders processed?
Shipper tyat make most money
Order with most quantity ordered?
