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

-- Orders by Company. Top 5 companies with the most orders
SELECT
  c.company_name,
  COUNT(o.order_id) AS order_count
FROM
  luisalva.north_wind_traders.orders o
JOIN
  luisalva.north_wind_traders.customers c
ON
  o.customer_id = c.customer_id
GROUP BY
  c.company_name
ORDER BY
  order_count DESC 


Employee with most orders processed?
Shipper with most orders processed?
Shipper tyat make most money
What is the city where most order go? What is the country?
Top 5 selling products? Most selling products?
Company that spend the most?
Yearly revenue
Monthly revenue
Top 5 expensiest order?
Order with quantity ordered?
Most selling category
Least selling category
