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



Company with most orders? top 5
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
