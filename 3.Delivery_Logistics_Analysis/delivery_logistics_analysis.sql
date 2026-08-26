CREATE DATABASE delivery_logistics_analysis;

DROP TABLE IF EXISTS delivery_logistics;
CREATE TABLE delivery_logistics(
		delivery_id INT,
		delivery_partner TEXT,
		package_type TEXT,
		vehicle_type TEXT,
		delivery_mode TEXT,
		region TEXT,
		weather_condition TEXT,
		distance_km NUMERIC(10,2),
		package_weight_kg NUMERIC(10,2),
		delivery_time_hours INT,
		expected_time_hours INT,
		delayed TEXT,
		delivery_status TEXT,
		delivery_rating INT,
		delivery_cost NUMERIC(10,2),
		delivery_difference_hours INT
);
SELECT * FROM delivery_logistics;


SELECT 
COUNT (*) 
FROM delivery_logistics

--Q1.How many total deliveries are there in the dataset?
SELECT 
COUNT(DISTINCT delivery_id)
FROM delivery_logistics;

--Q2.What percentage of deliveries were delayed?
SELECT 
	 delayed_deliveries *100 / total_deliveries AS delayed_delivery_percentage
FROM (
	SELECT 
		COUNT(delivery_id) AS total_deliveries,
		COUNT(delivery_id) FILTER(WHERE delayed = 'yes') AS delayed_deliveries
	FROM delivery_logistics
	)

--Q3.Which delivery partners handle the most deliveries?
SELECT 
	delivery_partner,
	COUNT(delivery_id) AS no_of_deliveries
FROM delivery_logistics
GROUP BY delivery_partner
ORDER BY no_of_deliveries DESC;

--Q4.Which delivery partners have the highest delay rate?
SELECT 
	delivery_partner,
	COUNT(delivery_id) FILTER(WHERE delayed = 'yes') *100 /COUNT(delivery_id) AS delayed_delivery_percentage
FROM delivery_logistics
GROUP BY delivery_partner
ORDER BY delayed_delivery_percentage DESC;

--Q5.Which delivery modes have the best average delivery performance?
SELECT 
	delivery_mode,
	ROUND(AVG(delivery_time_hours),2) AS avg_d_time
FROM delivery_logistics
GROUP BY delivery_mode
ORDER BY avg_d_time;

--Q6.Which regions have the highest number of delayed deliveries?
SELECT 
	region,
	COUNT(delivery_id) FILTER(WHERE delayed = 'yes') AS delay_orders
FROM delivery_logistics
GROUP BY region
ORDER BY delay_orders DESC;

--Q7.What is the average delivery time for each delivery partner?
SELECT
	delivery_partner,
	ROUND(AVG(delivery_time_hours),2) AS avg_delivery_time
FROM delivery_logistics
GROUP BY delivery_partner
ORDER BY avg_delivery_time;

--Q8.Which weather conditions have the highest delay rate?
SELECT 
	weather_condition,
	COUNT(delivery_id) FILTER(WHERE delayed = 'yes')*100 /
	COUNT(delivery_id) AS delay_rate
FROM delivery_logistics
GROUP BY weather_condition
ORDER BY delay_rate DESC;

--Q9.Which vehicle types have the highest average delivery cost?
SELECT
	vehicle_type,
	ROUND(AVG(delivery_cost),2) AS avg_cost
FROM delivery_logistics
GROUP BY vehicle_type
ORDER BY avg_cost DESC;

--Q10.Which package types have the highest average delivery cost?
SELECT 
	package_type,
	ROUND(AVG(delivery_cost),2) AS avg_cost
FROM delivery_logistics
GROUP BY package_type
ORDER BY avg_cost DESC;

--Q11.Which delivery partners have the highest average customer rating?
SELECT 
	delivery_partner,
	ROUND(AVG(delivery_rating),1) as avg_rating
FROM delivery_logistics
GROUP BY delivery_partner
ORDER BY avg_rating DESC;

--Q12.Which delivery partners perform above the overall average customer rating?
SELECT 
	delivery_partner, 
	ROUND(AVG(delivery_rating),1) AS avg_cust_rating
FROM delivery_logistics
GROUP BY delivery_partner
HAVING AVG(delivery_rating) > (SELECT avg(delivery_rating) FROM delivery_logistics)
ORDER BY avg_cust_rating DESC;

--Q13.Which delivery partners have both a delay rate above the overall delay rate and
--an average delivery cost above the overall average delivery cost?
WITH partner_metrics AS(
	SELECT 
		delivery_partner,
		ROUND(COUNT(delivery_id) FILTER(WHERE delayed ='yes') * 100.0/
		COUNT(delivery_id),2) AS delayed_rate,
		ROUND(AVG(delivery_cost),2) AS avg_delivery_cost
	FROM delivery_logistics
	GROUP BY delivery_partner
)
SELECT 
	delivery_partner,
	delayed_rate,
	avg_delivery_cost
FROM partner_metrics
WHERE
	delayed_rate > (SELECT AVG(delayed_rate) FROM partner_metrics)
	AND
	avg_delivery_cost > (SELECT AVG(avg_delivery_cost) FROM partner_metrics)

--Q14.Which delivery partners have the highest delay rate, but also handle a significant number of deliveries?
WITH partner_metric AS(
	SELECT 
		delivery_partner,
		COUNT(delivery_id) AS total_deliveries,
		COUNT(delivery_id) FILTER(WHERE delayed ='yes') AS delayed_deliveries,
		ROUND(COUNT(delivery_id) FILTER(WHERE delayed ='yes') *100.0 /
		COUNT(delivery_id),2) AS delayed_rate
	FROM delivery_logistics 
	GROUP BY delivery_partner
)
SELECT 
	delivery_partner,
	total_deliveries,
	delayed_deliveries,
	delayed_rate
FROM partner_metric
WHERE
    delayed_rate > (SELECT AVG(delayed_rate) FROM partner_metric)
    AND
    total_deliveries > (SELECT AVG(total_deliveries) FROM partner_metric)
ORDER BY delayed_rate DESC, total_deliveries, delayed_deliveries ;

--Q15.Which delivery partners provide the best overall operational performance by balancing delivery speed, 
-- delay rate, and customer rating?
WITH partner_performance AS (
	SELECT 
		delivery_partner,
		ROUND(AVG(delivery_time_hours),2) AS avg_delivery_time,
		ROUND(COUNT(delivery_id) FILTER(WHERE delayed ='yes') * 100.0
			/COUNT(delivery_id),2) AS delayed_rate,
		ROUND(AVG(delivery_rating),2) AS avg_rating
	FROM delivery_logistics
	GROUP BY delivery_partner
)
SELECT 
	delivery_partner,
	avg_delivery_time,
	delayed_rate,
	avg_rating,
	RANK() OVER(ORDER BY avg_delivery_time ASC, delayed_rate ASC, avg_rating DESC) AS rnk_delivery_partner
FROM partner_performance;