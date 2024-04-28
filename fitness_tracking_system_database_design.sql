-- SQL Server Management Studio						20.0.70.0
-- Server version: Microsoft SQL Server 2022 (RTM) - 16.0.1000.6 (X64)   Oct  8 2022 05:58:25   Copyright (C) 2022 Microsoft Corporation  Express Edition (64-bit) on Windows 10 Pro 10.0 <X64> (Build 19045: ) 

CREATE DATABASE fitness_tracking_system;

--
-- Table structure for 'users'
--
-- Dropping table if exists
IF OBJECT_ID('users', 'U') IS NOT NULL
    DROP TABLE users;

-- Creating users table
CREATE TABLE users (
    user_id INT PRIMARY KEY NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    join_date DATE
);

--
-- Table structure for 'goal'
--
-- Dropping table if exists
IF OBJECT_ID('goal', 'U') IS NOT NULL
    DROP TABLE goal;

-- Creating goal table
CREATE TABLE goal (
	goal_id INT PRIMARY KEY,
	user_id INT,
	goal_name VARCHAR(50),
	start_date DATE,
	target_weight_kg INT,
	target_body_weight_percentage INT,
	target_daily_calories_cal INT,
	target_exercise_frequency INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--
-- Table structure for 'meal'
--
-- Dropping table if exists
IF OBJECT_ID('meal', 'U') IS NOT NULL
    DROP TABLE meal;

-- Creating meal table
CREATE TABLE meal (
	meal_id INT PRIMARY KEY,
	user_id INT,
	meal_log_date DATE,
	meal_type VARCHAR(50),
	calories_consumed_cal INT,
	protein_gm INT,
	carbs_gm INT,
	fat_gm INT
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--
-- Table structure for 'progress'
--
-- Dropping table if exists
IF OBJECT_ID('progress', 'U') IS NOT NULL
    DROP TABLE progress;

-- Creating progress table
CREATE TABLE progress (
	progress_id INT PRIMARY KEY,
	user_id INT,
	progress_log_date DATE,
	body_dat_percentage INT,
	weight_kg INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--
-- Table structure for 'workout'
--
-- Dropping table if exists
IF OBJECT_ID('workout', 'U') IS NOT NULL
    DROP TABLE workout;

-- Creating workout table
CREATE TABLE workout (
	workout_id INT PRIMARY KEY,
	user_id INT,
	workout_name VARCHAR(50),
	workout_duration VARCHAR(50)
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

--
-- Table structure for 'exercise'
--
-- Dropping table if exists
IF OBJECT_ID('exercise', 'U') IS NOT NULL
    DROP TABLE exercise;

-- Creating exercise table
CREATE TABLE exercise (
	exercise_id INT PRIMARY KEY,
	exercise_name VARCHAR(50),
	exercise_category VARCHAR(50),
	equipment_required BIT
);

--
-- Table structure for 'workout_exercise'
--
-- Dropping table if exists
IF OBJECT_ID('workout_exercise', 'U') IS NOT NULL
    DROP TABLE workout_exercise;

-- Creating workout_exercise table
CREATE TABLE workout_exercise (
	workout_id INT,
	exercise_id INT,
	sets INT,
	reps INT,
	weight_lifted INT,
	duration TIME,
	FOREIGN KEY (workout_id) REFERENCES workout(workout_id),
	FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id)
);

