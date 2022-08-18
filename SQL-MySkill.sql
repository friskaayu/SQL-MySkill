/*
From the ecommerce_event table, write a SQL query to output: 
a. Total Unique user_session
b. Min, Max, and Average price
With criteria event_type is view, and brand except apple and samsung
*/

SELECT 
  COUNT(DISTINCT user_session) AS total_user_session,
  MIN(price) AS minimum_price, 
  MAX(price) AS maximum_price, 
  AVG(price) AS average_price
FROM ecommerce_event
WHERE 
  event_type='view' 
  AND brand NOT IN ('samsung', 'apple');
  
/*
From the ecommerce_event table, write a SQL query to output Total Unique product_id. 
filter brand which start with ‘a’ or ‘k’ letter, and date after ‘2019-10-04’
*/

SELECT 
COUNT(DISTINCT product_id) AS total_product
FROM ecommerce_event
WHERE (brand LIKE 'a%' OR brand LIKE 'k%') 
AND event_date > '2019-10-04'

/*
From the ecommerce_event table, write a SQL query to output total unique product and 
total unique user, for every order date. Only show the date above 04 august 2019, 
and sort the result by the latest date
*/

SELECT 
COUNT(DISTINCT product_id) as total_product, 
COUNT(DISTINCT user_id) AS total_user, event_date
FROM ecommerce_event
WHERE 
event_date > '2019-08-04'
GROUP by event_date
ORDER BY event_date DESC

/*
From the question  3, filter only dates that have total_product more than 500
*/

SELECT 
COUNT(DISTINCT product_id) as total_product, 
COUNT(DISTINCT user_id) AS total_user, event_date
FROM ecommerce_event
WHERE event_date > '2019-08-04' 
GROUP by event_date
HAVING total_product > 500
ORDER BY event_date DESC

/*
From the question  3, filter only dates that have total_product more than 500
*/

SELECT 
COUNT( DISTINCT e.user_session) as  total_session, 
u.gender
FROM ecommerce_event e
LEFT JOIN user_profile u 
ON e.user_id = u.user_id
WHERE e.event_date LIKE '2019-10-%' 
GROUP BY u.gender

/*
From the event and user table, is it true that iphone has more dominated by female and samsung dominated by male?
*/

SELECT e.brand, u.gender, COUNT(DISTINCT e.user_id) AS total_user
FROM ecommerce_event e
LEFT JOIN user_profile u ON e.user_id = u.user_id
WHERE e.brand = 'apple' OR e.brand = 'samsung'
GROUP BY e.brand, u.gender

/*
From the event and user table, show total user, product, and session, in every ages. Exclude age with  total_user more than 320 
*/

SELECT 
u.age, COUNT(DISTINCT e.user_id) AS total_user, COUNT(DISTINCT e.product_id) as total_product, 
COUNT(DISTINCT e.user_session) as total_session
FROM ecommerce_event e
LEFT JOIN user_profile u 
ON e.user_id = u.user_id
GROUP BY u.age
HAVING total_user <= 320

/*
Calculate the daily revenue and unique users for each date
*/

SELECT event_date, ROUND(SUM(price),2) AS revenue,
COUNT (DISTINCT user_id) AS total_user
FROM ecommerce_event 
WHERE event_type = 'purchase'
GROUP BY event_date
ORDER BY event_date

/*
Calculate the daily revenue and unique users for each date for male users
*/

SELECT e.event_date, ROUND(SUM(e.price),2) AS revenue,
COUNT (DISTINCT e.user_id) AS total_user
FROM ecommerce_event e
LEFT JOIN user_profile u ON e.user_id = u.user_id
WHERE e.event_type = 'purchase' 
AND u.gender = 'Male'
GROUP BY e.event_date
ORDER BY  e.event_date

/*
Calculate the daily average revenue per user (Revenue/ # users) for date with revenue higher than 3000
*/

SELECT event_date, revenue, ROUND(revenue/total_user,2) AS ARPU
FROM
	(SELECT e.event_date, ROUND(SUM(e.price),2) AS revenue,
	 COUNT (DISTINCT e.user_id) AS total_user
	 FROM ecommerce_event e
	 LEFT JOIN user_profile u ON e.user_id = u.user_id
	 WHERE e.event_type = 'purchase' 
	 GROUP BY e. event_date
	 HAVING revenue > 3000
	 ORDER BY e.event_date)
ORDER BY ARPU DESC










