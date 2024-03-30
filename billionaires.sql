SELECT * 
FROM billionaires;

SELECT *
FROM countries;

-- Retrieve the top 10 richest billionaires based on their wealth.
SELECT * 
FROM billionaires
ORDER BY wealth DESC
LIMIT 10;
-- List all billionaires who are younger than 30 years old.
SELECT *
FROM billionaires
WHERE age < 30;

-- Find the average age of billionaires in each industry.
SELECT AVG(age) AS average_age
FROM billionaires;

-- Identify the country with the highest number of billionaires.
SELECT 
	c.country,
    COUNT(b.id) as billionaire_count
FROM countries c
JOIN billionaires b ON c.id = b.country_id
GROUP BY country
ORDER BY billionaire_count DESC
LIMIT 1;

-- Calculate the total wealth of billionaires in each industry.
SELECT
	SUM(wealth) as total_wealth,
    industry
FROM billionaires
GROUP BY industry;

-- List the top 5 industries with the highest average wealth among billionaires.
SELECT
	AVG(wealth) as total_wealth,
    industry
FROM billionaires
GROUP BY industry
LIMIT 5;

-- Find the wealthiest billionaire in each country.
SELECT 
	c.country,
    b.first_name
FROM countries c
JOIN billionaires b ON c.id = b.country_id
WHERE (b.wealth, b.country_id) IN (
	SELECT MAX(wealth), country_id
    FROM billionaires
    GROUP BY country_id);

-- Determine the percentage of male and female billionaires.
SELECT
	(COUNT(CASE WHEN gender = 'M' THEN 1 END)/COUNT(*) * 100) AS male_percentage,
    (COUNT(CASE WHEN gender = 'F' THEN 1 END)/COUNT(*) * 100) AS female_percentage
FROM billionaires;

-- List all billionaires whose source of wealth is "Technology" and their wealth is above $10 billion.
SELECT *
FROM billionaires
WHERE industry= 'Technology' AND wealth > 10000;

-- Find the age distribution of billionaires (e.g., number of billionaires in each age group).
SELECT 
	COUNT(CASE WHEN age>=10 AND age<20 THEN 1 END) AS '10-20',
    COUNT(CASE WHEN age>=20 AND age<30 THEN 1 END) AS '20-30',
    COUNT(CASE WHEN age>=30 AND age<40 THEN 1 END) AS '30-40',
    COUNT(CASE WHEN age>=40 AND age<50 THEN 1 END) AS '40-50',
    COUNT(CASE WHEN age>=50 AND age<60 THEN 1 END) AS '50-60',
    COUNT(CASE WHEN age>=60 AND age<70 THEN 1 END) AS '60-70',
    COUNT(CASE WHEN age>=70 AND age<80 THEN 1 END) AS '70-80',
    COUNT(CASE WHEN age>=80 AND age<90 THEN 1 END) AS '80-90',
    COUNT(CASE WHEN age>=90 AND age=100 THEN 1 END) AS '90-100'
FROM billionaires;

SELECT * FROM billionaires WHERE age>=10 AND age<20;

SELECT * FROM billionaires WHERE last_name = 'Del Vecchio';

-- Calculate the total wealth of billionaires from each country and order the results by total wealth.
SELECT SUM(b.wealth) AS total_wealth , c.country
FROM billionaires b
JOIN countries c ON c.id = b.country_id
GROUP BY c.country
ORDER BY SUM(b.wealth) DESC;

-- List the top 3 countries with the highest number of billionaires in the technology industry.
SELECT c.country, COUNT(b.first_name) AS billionaires_count
FROM billionaires b
JOIN countries c ON b.country_id = c.id
GROUP BY c.country
ORDER BY COUNT(b.first_name) DESC
LIMIT 3;

-- Find the youngest billionaire in each industry.
SELECT MIN(age) AS youngest, industry
FROM billionaires
GROUP BY industry;

-- Identify billionaires who were born in the same year.
SELECT
    b1.first_name AS first_name_1,
    b1.last_name AS last_name_1,
    b1.birth_date AS birth_date_1,
    b2.first_name AS first_name_2,
    b2.last_name AS last_name_2,
    b2.birth_date AS birth_date_2
FROM
    billionaires b1
JOIN
    billionaires b2 ON b1.birth_date = b2.birth_date
WHERE
    b1.id < b2.id;
    
-- Calculate the average wealth of billionaires in each country and display the results in descending order.
SELECT c.country, AVG(b.wealth) AS avg_wealth
FROM billionaires b
JOIN countries c ON b.country_id = c.id
GROUP BY c.country
ORDER BY AVG(b.wealth) DESC;

-- List billionaires who have a source of wealth related to "Real Estate" and are from countries with a population above 100 million.
SELECT CONCAT(b.first_name,' ' ,b.last_name) AS billionaires_meeting_criteria
FROM billionaires b
INNER JOIN countries c ON c.id = b.country_id
WHERE b.industry = 'Real Estate' AND c.population > 100000000;
-- Find the age difference between the oldest and youngest billionaires.
SELECT (MAX(age) - MIN(age)) AS age_diff
FROM billionaires;

-- Identify billionaires whose wealth is in the top 10% among all billionaires.

-- Calculate the 10% threshold for the top wealthiest billionaires
SET @TenPercnt = (SELECT COUNT(*) / 10 FROM billionaires);

-- Retrieve the top 10% wealthiest billionaires
SELECT
    first_name,
    last_name,
    wealth
FROM
    billionaires
ORDER BY
    wealth DESC
LIMIT (SELECT @TenPercnt);

-- Calculate the percentage of billionaires in each age group (e.g., under 40, 40-50, 50-60, etc.).

-- Finding out the youngest and oldest billionaires.
SELECT MAX(age) AS max_age, MIN(age) AS min_age
FROM billionaires;

SELECT 
	(COUNT(CASE WHEN age>=10 AND age<20 THEN 1 END)/COUNT(*) * 100) AS '10-20',
	(COUNT(CASE WHEN age>=20 AND age<30 THEN 1 END)/COUNT(*) * 100) AS '20-30',
	(COUNT(CASE WHEN age>=30 AND age<40 THEN 1 END)/COUNT(*) * 100) AS '30-40',
    (COUNT(CASE WHEN age>=40 AND age<50 THEN 1 END)/COUNT(*) * 100) AS '40-50',
	(COUNT(CASE WHEN age>=50 AND age<60 THEN 1 END)/COUNT(*) * 100) AS '50-60',
	(COUNT(CASE WHEN age>=60 AND age<70 THEN 1 END)/COUNT(*) * 100) AS '60-70',
    (COUNT(CASE WHEN age>=70 AND age<80 THEN 1 END)/COUNT(*) * 100) AS '70-80',
    (COUNT(CASE WHEN age>=80 AND age<90 THEN 1 END)/COUNT(*) * 100) AS '80-90',
	(COUNT(CASE WHEN age>=90 AND age<100 THEN 1 END)/COUNT(*) * 100) AS '90-100',
    (COUNT(CASE WHEN age>=100 AND age<110 THEN 1 END)/COUNT(*) * 100) AS '100-110'
FROM billionaires;
