--Checking my data on how it looks like before i start using it.
SELECT*
FROM casestudy.brightcoffee.brightcoffe_table
LIMIT 100;

--Checking if there are any duplicates in my data. 
SELECT transaction_id,
COUNT(*) AS duplicate_count
FROM casestudy.brightcoffee.brightcoffe_table
GROUP BY transaction_id 
HAVING COUNT(*)>1;

-- Checking for nulls and blanks in my data. 
SELECT COUNT(*) AS missing_products
FROM casestudy.brightcoffee.brightcoffe_table
WHERE  product_detail =''
OR product_detail is NULL;

--What are the business hours of this coffe shop?
SELECT MIN(transaction_time) AS opening_time,
MAX(transaction_time) AS closing_time
FROM casestudy.brightcoffee.brightcoffe_table;

--What are the business days of this coffe shop?
SELECT MIN(transaction_date) AS start_date,
MAX (transaction_date) AS last_date
FROM casestudy.brightcoffee.brightcoffe_table; 

--How many differnt products are we selling in total?
SELECT COUNT(DISTINCT product_id) AS number_of_products
FROM casestudy.brightcoffee.brightcoffe_table;

--What are different product_category do we have in the Coffe shop?
SELECT DISTINCT product_category
FROM casestudy.brightcoffee.brightcoffe_table;

--What are different types of products are we selling?
SELECT DISTINCT product_type
FROM casestudy.brightcoffee.brightcoffe_table;  

--Which product_category generates the most revenue? 
SELECT product_category,
SUM(unit_price) AS total_revenue
FROM casestudy.brightcoffee.brightcoffe_table;
GROUP BY product_category;

--When did we start collecting this data, and when last did we collect the last record?
SELECT MIN(transaction_date) AS start_date, 
MAX(transaction_date) AS last_date
FROM casestudy.brightcoffee.brightcoffe_table;

--Which product generates the most revenue?
SELECT product_type,
SUM(unit_price) AS total_revenue
FROM casestudy.brightcoffee.brightcoffe_table; 
GROUP BY product_type
ORDER BY total_revenue DESC;

--Which product has the highest unit price?
SELECT DISTINCT product_type,unit_price
FROM casestudy.brightcoffee.brightcoffe_table
ORDER BY unit_price DESC;

--How many stores do we have?
SELECT DISTINCT store_location
FROM casestudy.brightcoffee.brightcoffe_table;

--How many products are we selling per store?
SELECT store_location,
COUNT(DISTINCT product_id) AS number_of_products
FROM casestudy.brightcoffee.brightcoffe_table
GROUP BY store_location;

--Calculating the total_revenue of our coffe shop?
SELECT SUM(CAST(transaction_qty AS DOUBLE) * (CAST(REPLACE(unit_price, ',', '.') AS DOUBLE))) AS total_revenue
FROM casestudy.brightcoffee.brightcoffe_table;

--Calculating the total number of transactions in our coffe shop
SELECT COUNT(DISTINCT transaction_id) AS total_sales
FROM casestudy.brightcoffee.brightcoffe_table;

--Calculating  the total number of unit sold in our coffe shop
SELECT SUM(transaction_qty) AS total_unit_sold
FROM casestudy.brightcoffee.brightcoffe_table;

--BIG CODE
--Adding the new colomns to enhance our data.
SELECT
transaction_date,
DAYNAME(transaction_date) AS Day_name,
MONTHNAME(transaction_date) AS Month_name,

--Sales Metric
COUNT(transaction_id) AS number_of_sales, 
SUM(CAST(transaction_qty AS DOUBLE)) AS unit_sold,
COUNT(DISTINCT product_id) AS unique_products, 
COUNT(store_id) AS number_of_stores,
SUM(CAST(transaction_qty AS DOUBLE) * (CAST(REPLACE(unit_price, ',', '.') AS DOUBLE))) AS total_revenue,

--Case statements always creates buckets(big groupings)for enhanced analysis.
CASE 
WHEN DAYNAME(transaction_date) IN ('Satur','Sun') THEN 'Weekend'
WHEN DAYNAME(transaction_date) IN ('Mon','Tue','Wed','Thurs','Fri')THEN 'Weekday'
END AS day_classification,

CASE 
WHEN transaction_time BETWEEN '06:00:00'AND '11:59:59' THEN 'Morning'
WHEN transaction_time BETWEEN '12:00:00'AND '17:59:59' THEN 'Afternoon'
WHEN transaction_time BETWEEN '18:00:00' AND '20:59:59' THEN 'Evening'
END AS time_classification,

store_location,
product_category,
product_type,
product_detail

FROM casestudy.brightcoffee.brightcoffe_table
  
GROUP BY ALL;

GROUP BY ALL;
