---How many orders per month? Months with most orders
SELECT
  EXTRACT(YEAR_MONTH FROM order_date) AS order_month,
  COUNT(order_id) order_count
FROM
  luisalva.north_wind_traders.orders
GROUP BY
  order_month
ORDER BY
  order_month DESC;
