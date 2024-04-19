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
SELECT c.company_name, o.order_id, round(sum(od.unit_price * od.quantity), 2) as order_total_cost
FROM luisalva.north_wind_traders.customers c
JOIN luisalva.north_wind_traders.orders o
ON o.customer_id = c.customer_id
join luisalva.north_wind_traders.order_details od
on od.order_id = o.order_id 
group by o.order_id, c.company_name
order by order_total_cost desc

  
Employee with most orders processed?
Shipper with most orders processed?
Shipper tyat make most money
What is the city where most order go? What is the country?
Top 5 selling products? Most selling products?
Company that spend the most?
Yearly revenue
Monthly revenue
Top 5 expensiest order?
Order with most quantity ordered?
Most selling category
Least selling category
