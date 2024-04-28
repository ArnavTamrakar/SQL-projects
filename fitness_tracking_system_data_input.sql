-- Inserting data in to users table
INSERT INTO users (user_id, username, password_hash, first_name, last_name, join_date)
VALUES
(1, 'arnav', 'imhappy111', 'Arnav', 'Tamrakar', '2021-03-03'),
(2, 'ansuu', 'imhappy222', 'Ansu', 'Manandhar', '2020-07-03'),
(3, 'sugoy', 'imhappy333', 'Suyog', 'Fattaju', '2023-05-02'),
(4, 'adarsha', 'imhappy444', 'Adarsh', 'Bajracharya', '2023-09-04'),
(5, 'manjil', 'imhappy555', 'Manjil', 'Shrestha', '2023-03-22'),
(6, 'sizuka', 'imhappy777', 'Sizuka', 'Adhikari', '2022-07-07'),
(7, 'sugouy', 'imhappy888', 'Suyog', 'Shrestha', '2022-01-01'),
(8, 'saul', 'imhappy333', 'Sam', 'Sulek', '2019-05-02'),
(9, 'dave', 'password9', 'David', 'Martinez', '2020-06-15'),
(10, 'tay', 'password10', 'Jessica', 'Taylor', '2024-12-30'),
(11, 'chris', 'password11', 'Christopher', 'Anderson', '2023-04-18'),
(12, 'sarah', 'password12', 'Sarah', 'Wilson', '2020-07-22'),
(13, 'john', 'password4', 'John', 'Doe', '2019-06-15'),
(14, 'jane', 'password5', 'Jane', 'Smith', '2020-09-20'),
(15, 'alice', 'password6', 'Alice', 'Johnson', '2021-03-10'),
(16, 'mike', 'password7', 'Michael', 'Brown', '2022-11-25'),
(17, 'Em', 'password8', 'Emily', 'Davis', '2019-09-05');

-- Inserting data in to exercise table
INSERT INTO exercise(exercise_id, exercise_name, exercise_category, equipment_required)
VALUES
(1, 'Barbell Bench Press', 'Strenth Training', 1),
(2, 'Push Up', 'Calisthenics', 0),
(3, 'Pull Up', 'Calisthenics', 0),
(4, 'Lats Pulldown', 'Strength Traning', 1),
(5, 'Bodyweight Squats', 'Calisthenics', 0),
(6, 'Running', 'Cardiovascular', 0),
(7, 'Deadlifts', 'Strength Training', 1),
(8, 'Pilates', 'Flexibility and Core Strength', 0), 
(9, 'Bicep Curls', 'Strength Training', 1), 
(10, 'Indoor Cycling', 'Cardiovascular', 1),
(11, 'Weighted Squats', 'Strength Training', 1), 
(12, 'Dips', 'Strength Training', 1); 

-- Inserting data in to goal table
INSERT INTO goal (goal_id, user_id, goal_name, start_date, target_weight_kg, target_body_weight_percentage, target_daily_calories_cal, target_exercise_frequency)
VALUES
(1, 2, 'Weight Loss', '2024-01-01', 50, 15, 1800, 3),
(2, 1, 'Muscle Gain', '2024-02-15', 85, 10, 2500, 5),
(3, 10, 'Fitness Maintenance', '2024-03-10',70, 15, 2000, 4),
(4, 15, 'Flexibility Improvement', '2024-04-01',55, 15, 1800, 6),
(5, 16, 'Endurance Enhancement', '2024-05-05', 70, 15, 2200, 6);

-- Inserting data in to meal table
INSERT INTO meal (meal_id, user_id, meal_log_date, meal_type, calories_consumed_cal, protein_gm, carbs_gm, fat_gm)
VALUES 
(1, 2, '2024-01-01', 'Breakfast', 400, 20, 40, 10),
(2, 1, '2024-01-01', 'Lunch', 600, 30, 50, 15),
(3, 4, '2024-01-01', 'Dinner', 800, 40, 60, 20),
(4, 10, '2024-01-02', 'Breakfast', 450, 25, 45, 12),
(5, 6, '2024-01-02', 'Lunch', 700, 35, 55, 18),
(6, 1, '2024-01-02', 'Dinner', 850, 45, 65, 22),
(7, 3, '2024-01-03', 'Breakfast', 500, 30, 50, 14),
(8, 7, '2024-01-03', 'Lunch', 650, 40, 60, 16),
(9, 15, '2024-01-03', 'Dinner', 900, 50, 70, 25),
(10, 8, '2024-01-04', 'Breakfast', 420, 22, 42, 11);

-- Inserting data into progress table
INSERT INTO progress (progress_id, user_id, progress_log_date, weight_kg)
VALUES 
(1, 2, '2024-01-01', 55),
(2, 1, '2024-01-03', 82),
(3, 13, '2024-01-05', 80),
(4, 15, '2024-01-07', 54),
(5, 10, '2024-01-09', 73);

-- Inserting data into workout table
INSERT INTO workout (workout_id, user_id, workout_name, workout_duration)
VALUES 
(1, 2, 'Morning Jog', '00:30:00'), -- 30 minutes
(2, 1, 'Strength Training', '01:15:00'), -- 1 hour and 15 minutes
(3, 8, 'Yoga Session', '00:45:00'), -- 45 minutes
(4, 7, 'Cardio Workout', '00:40:00'), -- 40 minutes
(5, 9, 'HIIT Circuit', '00:50:00'), -- 50 minutes
(6, 11, 'Afternoon Walk', '00:20:00'), -- 20 minutes
(7, 12, 'Bodyweight Exercises', '00:55:00'), -- 55 minutes
(8, 6, 'Swimming Laps', '01:30:00'), -- 1 hour and 30 minutes
(9, 3, 'Pilates Class', '01:00:00'), -- 1 hour
(10, 15, 'Evening Bike Ride', '01:10:00'); -- 1 hour and 10 minutes

-- Inserting data into workout_exercise table
INSERT INTO workout_exercise (workout_id, exercise_id, reps, weight_lifted, duration)
VALUES
(1, 13, 0, 0, '00:30:00'),
(2, 2, 20, 0, '00:02:00'),
(2, 2, 15, 0, '00:01:50'),
(2, 2, 12, 0, '00:01:30'),
(2, 1, 15, 70, '00:01:30'),
(2, 1, 10, 80, '00:01:00'),
(2, 1, 5, 90, '00:00:40'),
(7, 2, 20, 0, '00:02:00'),
(7, 2, 20, 0, '00:02:00'),
(7, 2, 20, 0, '00:02:00'),
(7, 5, 30, 0, '00:04:00'),
(7, 5, 25, 0, '00:03:40'),
(7, 5, 30, 0, '00:04:00'),
(7, 3, 10, 0, '00:01:30'),
(7, 3, 8, 0, '00:01:00'),
(7, 5, 8, 0, '00:01:00'),
(7, 12, 15, 0, '00:02:00'),
(7, 12, 15, 0, '00:02:00');

