-- How many orders per month? Months with most orders
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

  
-- Total orders by Company. Top 5 companies with the most orders
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

  
--Total money spent by each company? Top 5 companies with more money spent
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
  
Employee with most orders processed?
Shipper with most orders processed?
Shipper tyat make most money
What is the city where most order go? What is the country?
Top 5 selling products? Most selling products?
Revenue by year
Revenue by month
Order with most quantity ordered?
Most selling category
Least selling category
