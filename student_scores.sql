-- BRIEF: The dataset consists of just one table named student_scores which has all the necessary data in it. I didnt have to normalize or clean it as it was in 3NF and pretty clean.


SELECT * FROM student_scores;

-- How many student are there in total?
SELECT COUNT(*) 
FROM student_scores;

-- How many males and females? Any other gender besides those two?
SELECT 
	COUNT(CASE WHEN gender='male' THEN 1 END) AS maleCount,
	COUNT(CASE WHEN gender='female' THEN 1 END) AS femaleCount
FROM student_scores;

-- The minimum requirement to give the next exam is to have no more that 8 absent days. How many student cannot attend the next exam? Write another query to show id, full name and email.
SELECT COUNT(CASE WHEN absence_days >= 8 THEN 1 END) AS cantAttend
FROM student_scores;

SELECT *
FROM student_scores
WHERE absence_days>= 8;
-- A job recruiter is looking for english language tutors. Find students with no part time job and more that 95 in english.

SELECT * 
FROM student_scores
WHERE part_time_job = 'FALSE' AND english_score > 95;

-- Find the top 5 students with the highest average score across math, history, physics, chemistry, biology, English, and geography.
SELECT 
	first_name
FROM 
	(SELECT 
		AVG(math_score + history_score + physics_score + chemistry_score + biology_score + geography_score + english_score) AS averageScore,
        first_name
	FROM student_scores
	GROUP BY first_name
	ORDER BY averageScore DESC) AS average
LIMIT 5;

-- Find the students who have both a part-time job and participate in extracurricular activities.
SELECT * 
FROM student_scores
WHERE part_time_job = 'TRUE' AND extracurricular_activities = 'TRUE';

-- Calculate the average weekly self-study hours for male and female students separately.
SELECT 
	COUNT(CASE WHEN gender = 'male' THEN weekly_self_study_hours END) AS maleHours,
	COUNT(CASE WHEN gender = 'female' THEN weekly_self_study_hours END) AS femaleHours
FROM student_scores;

-- Identify the student(s) with the lowest total score across all subjects.
SELECT first_name AS lowest_total_score
FROM (
		SELECT 
			first_name, 
			(math_score + history_score + physics_score + chemistry_score + biology_score + geography_score + english_score) AS totalscore
		FROM student_scores
		GROUP BY first_name, totalscore
		ORDER BY totalscore
		LIMIT 1) AS minFinder;
     
-- Find the students whose career aspiration includes "Doctor" and have a math score above 90.
SELECT * 
FROM student_scores
WHERE career_aspiration = 'Doctor' AND math_score > 90;

-- Retrieve the full names and email addresses of students who have scored above 80 in math, along with their gender information.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
	email,
	gender
FROM student_scores
WHERE math_score > 80;
-- List the students who have a part-time job and have also participated in extracurricular activities, along with their career aspirations.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
	career_aspiration
FROM student_scores
WHERE part_time_job= 'TRUE' AND extracurricular_activities = 'TRUE';

-- Retrieve the names of students who have scored above the average in all subjects (math, history, physics, chemistry, biology, English, and geography).
SELECT first_name
FROM (
    SELECT 
        first_name,
        math_score + history_score + physics_score + chemistry_score + biology_score + geography_score + english_score AS total_score
    FROM student_scores
) AS score_totals
WHERE total_score > (
    SELECT AVG(math_score + history_score + physics_score + chemistry_score + biology_score + geography_score + english_score)
    FROM student_scores
);
-- List the students who have a career aspiration of "Engineer" and have scored above 85 in math or physics.
SELECT *
FROM student_scores
WHERE career_aspiration LIKE '%Engineer%' AND (math_score > 85 OR physics_score > 85);

-- Retrieve the names and email addresses of students who have not missed any days of absence, along with their gender information.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    gender
FROM student_scores
WHERE absence_days = 0;

-- Retrieve the full names and email addresses of students who have scored above 80 in math, along with their gender information.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    email,
    gender
FROM student_scores
WHERE absence_days = 0;

-- List the students who have a part-time job and have also participated in extracurricular activities, along with their career aspirations.
SELECT 
	CONCAT(first_name, ' ', last_name) AS full_name,
    career_aspiration
FROM student_scores
WHERE part_time_job = 'TRUE' AND extracurricular_activities = 'TRUE';

-- Retrieve the names of students who have scored above the average in all subjects (math, history, physics, chemistry, biology, English, and geography).
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM student_scores
WHERE math_score > (SELECT AVG(math_score) FROM student_scores) 
	AND history_score > (SELECT AVG(history_score) FROM student_scores) 
	AND physics_score > (SELECT AVG(physics_score) FROM student_scores) 
    AND chemistry_score > (SELECT AVG(chemistry_score) FROM student_scores)
    AND biology_score > (SELECT AVG(biology_score) FROM student_scores)
    AND english_score > (SELECT AVG(english_score) FROM student_scores)
    AND geography_score > (SELECT AVG(geography_score) FROM student_scores);

