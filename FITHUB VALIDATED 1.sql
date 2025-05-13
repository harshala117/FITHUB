-- Database : Fithub --
CREATE DATABASE FitHub;
USE FitHub;

-- LOOKUP TABLE --

CREATE TABLE PaymentMethods (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL UNIQUE
);

-- TABLES --

CREATE TABLE Memberships (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50),
    duration_months INT,
    price DECIMAL(10,2),
    benefits TEXT
);

CREATE TABLE Trainers (
    trainer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    dob DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    join_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    membership_id INT,
    FOREIGN KEY (membership_id) REFERENCES Memberships(membership_id)
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    method_id INT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (method_id) REFERENCES PaymentMethods(method_id)
);

CREATE TABLE Workout_Plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    goal VARCHAR(100),
    duration_weeks INT
);

CREATE TABLE Member_Workout_Plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    plan_id INT,
    start_date DATE,
    end_date DATE,
    status ENUM('Active', 'Completed', 'Paused') DEFAULT 'Active',
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (plan_id) REFERENCES Workout_Plans(plan_id)
);

CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    purchase_date DATE,
    maintenance_date DATE,
    status ENUM('Available', 'In Maintenance', 'Retired') DEFAULT 'Available'
);

CREATE TABLE Sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    trainer_id INT,
    session_date DATE,
    duration_minutes INT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

CREATE TABLE Session_Equipment_Usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT,
    equipment_id INT,
    duration_minutes INT,
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    schedule_time DATETIME,
    trainer_id INT,
    capacity INT,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

CREATE TABLE Class_Registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    class_id INT,
    registration_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- SECURITY TABLES --

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Trainer', 'Member') NOT NULL
);

CREATE TABLE LoginHistory (
    login_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    login_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    logout_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ENHANCEMENTS --

CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT,
    scheduled_time DATETIME,
    sent BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- AUDIT TABLES --

CREATE TABLE MemberAudit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    action_type VARCHAR(20),
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);

CREATE TABLE TrainerAudit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    trainer_id INT,
    action_type VARCHAR(20),
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT
);

-- INSERT INTO VALUES --

INSERT INTO PaymentMethods (method_name) VALUES ('Cash'), ('Card'), ('Online'), ('UPI');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Premium', 1, 166.95, 'Premium Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Standard', 3, 157.75, 'Standard Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 3, 323.13, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Standard', 12, 450.08, 'Standard Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Standard', 3, 56.16, 'Standard Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Basic', 6, 321.32, 'Basic Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Standard', 12, 224.09, 'Standard Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 12, 445.08, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Basic', 3, 115.55, 'Basic Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 3, 423.92, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 1, 447.57, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Standard', 1, 378.28, 'Standard Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Premium', 12, 470.71, 'Premium Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 6, 233.35, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Basic', 6, 114.85, 'Basic Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Premium', 12, 236.57, 'Premium Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 12, 387.63, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Premium', 6, 490.4, 'Premium Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Elite', 3, 321.23, 'Elite Plan Benefits');
INSERT INTO Memberships (type, duration_months, price, benefits) VALUES ('Basic', 1, 304.99, 'Basic Plan Benefits');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Brianna Diaz', 'Pilates', 'mariasolis@gmail.com', '5012355574', 2022.45, '2023-04-01');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Mr. Robert Cook', 'Cardio', 'william76@hotmail.com', '1488542699', 5995.16, '2025-03-08');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Marie Castillo', 'Strength', 'benjamin27@hotmail.com', '3636833519', 2666.47, '2023-08-15');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Kyle Cowan', 'Cardio', 'isaac90@davis.org', '3563620637', 3216.92, '2023-11-24');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Trevor Schmitt', 'Pilates', 'alec70@ramirez-greene.com', '9791613004', 2327.42, '2023-11-10');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Nathaniel Mcclain', 'Cardio', 'jacobdaniel@shelton-castaneda.org', '6163614422', 5143.42, '2025-02-18');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Leah Chambers', 'Pilates', 'asparks@hotmail.com', '8357249418', 4287.72, '2022-11-15');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Casey Quinn', 'Cardio', 'hmorales@keller.com', '7463421945', 4459.13, '2022-08-25');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Cristian Vazquez', 'Yoga', 'mrobertson@gmail.com', '2204967611', 2853.64, '2024-12-22');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Veronica Garcia', 'Yoga', 'deleonrebecca@gmail.com', '8968531206', 2041.75, '2024-11-09');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Marie Lawson', 'Strength', 'reginabest@gmail.com', '3626341230', 3319.06, '2025-02-08');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Ryan Bruce', 'Yoga', 'carol79@gmail.com', '8389637513', 5819.26, '2024-12-03');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Rebekah Wong', 'Strength', 'jennifer59@berry.info', '6600526042', 3644.41, '2024-06-07');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Sabrina Scott', 'Yoga', 'jamestrujillo@hotmail.com', '3346689415', 3920.89, '2023-01-17');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Bobby Sullivan', 'Pilates', 'aavery@hammond-morris.com', '0996835803', 2337.25, '2022-05-28');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Emily Cooper', 'Strength', 'philiposborne@warner-villanueva.net', '6117473055', 2814.47, '2025-02-02');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Joyce Strong', 'Pilates', 'stephanietaylor@curtis.org', '4367507062', 3316.0, '2024-09-15');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Michael Pierce', 'Cardio', 'steven83@hotmail.com', '7997269846', 5497.48, '2023-02-21');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Jason Santos', 'Pilates', 'leeperry@sims.biz', '1020196330', 5271.58, '2024-06-05');
INSERT INTO Trainers (name, specialization, email, phone, salary, hire_date) VALUES ('Charles Nguyen', 'Yoga', 'sherrymack@yahoo.com', '0736699594', 4255.74, '2024-12-02');
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Expect Plan', 'A smile other.', 'Muscle Gain', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Red Plan', 'Traditional win oil marriage recent ten put.', 'Muscle Gain', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Say Plan', 'Book ok crime bring money watch remain.', 'Weight Loss', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Computer Plan', 'Degree tough particularly box anyone.', 'Muscle Gain', 8);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Class Plan', 'Meeting far natural second reality determine.', 'Stamina', 6);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Information Plan', 'Style no help.', 'Stamina', 6);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Detail Plan', 'Early pretty himself serious.', 'Muscle Gain', 6);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Often Plan', 'Adult next key sell.', 'Muscle Gain', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Nation Plan', 'Ago hour only benefit.', 'Stamina', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Response Plan', 'Note now west hundred important player good.', 'Weight Loss', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Determine Plan', 'Require perform bar my surface.', 'Muscle Gain', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Require Plan', 'Customer public economy myself play possible.', 'Muscle Gain', 8);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Different Plan', 'Too scientist consumer read do.', 'Stamina', 12);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Commercial Plan', 'Skill every town.', 'Weight Loss', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Same Plan', 'Most site because machine couple card room.', 'Muscle Gain', 12);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Who Plan', 'Marriage design nearly federal use life hard.', 'Muscle Gain', 8);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Yeah Plan', 'Bed increase simple seat bar.', 'Muscle Gain', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Congress Plan', 'Case hair ahead site edge inside.', 'Weight Loss', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Civil Plan', 'Make least adult everything west understand sure.', 'Stamina', 4);
INSERT INTO Workout_Plans (name, description, goal, duration_weeks) VALUES ('Near Plan', 'Power evening whatever simple admit fund.', 'Stamina', 12);
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Hair Machine', 'Cardio', '2022-02-19', '2023-01-11', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Painting Machine', 'Strength', '2021-08-17', '2022-04-01', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Quite Machine', 'Cardio', '2023-07-01', '2024-05-31', 'Available');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Learn Machine', 'Strength', '2022-04-24', '2024-06-09', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Open Machine', 'Cardio', '2024-02-05', '2025-03-22', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Herself Machine', 'Strength', '2024-02-09', '2024-12-15', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Alone Machine', 'Cardio', '2021-12-22', '2023-04-10', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Administration Machine', 'Strength', '2023-12-31', '2024-09-17', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Left Machine', 'Strength', '2023-10-05', '2024-03-31', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('This Machine', 'Strength', '2021-12-16', '2023-09-01', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Near Machine', 'Cardio', '2021-10-25', '2025-03-09', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Key Machine', 'Strength', '2023-03-02', '2025-01-21', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Can Machine', 'Cardio', '2023-03-02', '2024-04-03', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Politics Machine', 'Cardio', '2022-02-23', '2022-08-14', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Important Machine', 'Cardio', '2020-06-21', '2021-09-15', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Attention Machine', 'Cardio', '2022-05-01', '2023-03-12', 'Available');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Measure Machine', 'Strength', '2024-01-16', '2025-02-09', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Occur Machine', 'Strength', '2022-02-05', '2023-08-16', 'In Maintenance');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Believe Machine', 'Cardio', '2023-09-15', '2024-08-23', 'Retired');
INSERT INTO Equipment (name, category, purchase_date, maintenance_date, status) VALUES ('Hear Machine', 'Cardio', '2024-04-06', '2024-08-24', 'In Maintenance');
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Dr. Donna Conley', 'Male', '1984-02-15', 'petersonjessica@hotmail.com', '0486393518', '3812 Padilla Corners Suite 761, Kennedyberg, NH 29717', '2025-02-18', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Alexis Henry', 'Female', '1964-11-18', 'craigsanders@guzman-moore.info', '9693449057', '598 Kyle Orchard Apt. 384, Xavierchester, LA 25841', '2023-01-08', 1);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Robin Wallace', 'Female', '2005-06-24', 'racheljohnson@gmail.com', '8772030364', '24503 Derek Knoll Apt. 070, Dickersonburgh, VT 51078', '2024-01-25', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Jacob Vasquez', 'Female', '2006-11-05', 'benjamin04@hotmail.com', '9979592238', '0137 Baker Stream, New Daniel, KY 72775', '2025-01-27', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Manuel Lopez', 'Female', '1999-10-13', 'rkramer@hotmail.com', '7832214264', '890 Dylan Port Suite 820, Lake Ashley, SD 32697', '2022-12-07', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Todd Rodgers', 'Other', '1999-09-14', 'david71@gmail.com', '9079256162', '1372 Christine Key, North Pennyfurt, IL 87040', '2022-09-25', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Mia Campbell', 'Male', '1985-08-06', 'lisa05@castillo.net', '6304420695', '258 Spencer Cliff Suite 497, Michaelview, NE 46172', '2023-09-30', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Mark Knapp', 'Other', '1979-10-23', 'evelyncampbell@gmail.com', '4787310962', '56807 Hill Meadow Suite 573, Lopezfurt, RI 97693', '2023-12-07', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Margaret Prince', 'Male', '1973-12-31', 'williambrown@wright.com', '6934930511', '76725 Banks Green Suite 927, Georgeport, TX 96268', '2023-02-19', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Julie Rosales DVM', 'Female', '1985-08-07', 'ydavis@hunt.com', '1491762223', '6660 Page Groves, Chaseville, WV 16436', '2022-07-28', 2);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Janet Powell', 'Female', '1998-08-20', 'jamie37@salinas-decker.biz', '3403731528', '4067 Park Square, Lake Melissa, SD 94587', '2024-04-05', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Jack Ellis', 'Other', '1987-10-22', 'jennifer11@charles.org', '5629147466', '348 Walters Causeway, Caitlynberg, NC 68466', '2024-09-18', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Larry Murphy', 'Male', '1979-03-07', 'geoffrey67@yahoo.com', '2227410227', '99935 Philip Glen, New Lisa, WV 97637', '2024-06-15', 1);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Kelly Maldonado', 'Male', '1976-01-26', 'doylestephanie@huber.com', '1774833928', '379 Angela Common, Christopherside, WY 65611', '2024-04-24', 1);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Gina Lewis', 'Other', '1983-01-09', 'leesarah@hanson.com', '9736227852', '68947 Samuel Turnpike Apt. 888, Brownstad, WY 17036', '2022-06-11', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Brian Grant', 'Other', '1978-09-02', 'edavis@gmail.com', '8193055633', '247 Angelica Burg, North Jacquelineside, PA 32328', '2023-06-23', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Robert Lopez', 'Female', '1994-02-01', 'robertramos@gmail.com', '0877726406', '723 Owens Lake Suite 788, Martinview, AK 29872', '2024-03-31', 1);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Daniel Moreno', 'Female', '1959-12-12', 'gonzalesrebecca@gmail.com', '7949084557', 'Unit 6925 Box 5503, DPO AA 60655', '2022-09-16', 4);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Christopher Buckley', 'Female', '1985-10-19', 'toddlopez@rivera-welch.com', '3667225385', '92906 Clark Mountains, Jeremyshire, NV 50765', '2024-01-25', 3);
INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id) VALUES ('Rhonda Alexander', 'Female', '1963-07-05', 'castillonicholas@young-wilson.org', '4556872998', '8467 Mark Way Suite 894, Jamesside, MT 88359', '2023-03-23', 2);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (11, 497.48, '2024-08-16', 2);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (1, 186.84, '2025-03-28', 1);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (3, 158.28, '2025-04-19', 3);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (6, 30.66, '2025-03-30', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (12, 419.35, '2025-02-28', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (7, 236.55, '2025-01-06', 3);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (15, 257.96, '2025-01-15', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (7, 287.4, '2024-09-26', 1);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (17, 218.63, '2024-06-12', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (13, 81.09, '2024-08-25', 3);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (14, 308.61, '2025-04-26', 3);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (10, 254.39, '2024-09-14', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (16, 281.42, '2025-01-19', 1);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (5, 411.44, '2025-02-20', 1);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (11, 288.61, '2025-04-10', 1);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (8, 193.16, '2025-02-12', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (8, 407.81, '2025-01-01', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (6, 148.25, '2024-09-09', 4);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (10, 308.13, '2024-10-12', 3);
INSERT INTO Payments (member_id, amount, payment_date, method_id) VALUES (13, 122.2, '2024-09-18', 3);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (13, 11, '2025-04-25', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (15, 15, '2025-05-05', 60);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (12, 11, '2025-04-26', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (7, 1, '2025-04-28', 60);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (14, 19, '2025-04-21', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (14, 3, '2025-05-01', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (3, 17, '2025-04-28', 60);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (14, 14, '2025-04-15', 30);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (1, 20, '2025-04-19', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (20, 18, '2025-04-26', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (2, 20, '2025-04-24', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (1, 4, '2025-04-20', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (3, 2, '2025-04-15', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (13, 9, '2025-04-20', 30);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (8, 11, '2025-04-16', 30);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (8, 7, '2025-04-22', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (13, 4, '2025-05-12', 60);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (18, 17, '2025-04-24', 30);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (7, 6, '2025-05-10', 45);
INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes) VALUES (17, 15, '2025-04-16', 45);
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (2, 13, '2025-03-10', '2025-04-24', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (18, 5, '2025-03-12', '2025-05-02', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (18, 4, '2025-03-03', '2025-05-01', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (5, 18, '2025-02-26', '2025-05-10', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (1, 1, '2025-03-16', '2025-05-12', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (3, 14, '2025-03-26', '2025-05-05', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (13, 2, '2025-04-01', '2025-05-08', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (7, 20, '2025-02-25', '2025-04-17', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (7, 8, '2025-02-24', '2025-04-28', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (11, 2, '2025-04-12', '2025-05-05', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (12, 11, '2025-03-25', '2025-05-08', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (14, 13, '2025-02-22', '2025-04-15', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (20, 15, '2025-04-03', '2025-04-23', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (18, 6, '2025-03-10', '2025-05-03', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (7, 8, '2025-02-14', '2025-04-29', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (15, 17, '2025-03-11', '2025-04-17', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (17, 9, '2025-02-20', '2025-05-04', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (7, 1, '2025-03-14', '2025-04-26', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (2, 7, '2025-02-22', '2025-04-25', 'Active');
INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status) VALUES (16, 10, '2025-02-13', '2025-04-21', 'Active');
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Zumba Class', '2025-05-30 05:50:10', 8, 15);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Zumba Class', '2025-05-28 07:25:01', 8, 16);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-06-10 22:21:31', 10, 21);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-05-31 11:40:48', 14, 30);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-05-26 10:28:33', 13, 22);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Yoga Class', '2025-05-18 05:13:43', 14, 12);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Zumba Class', '2025-05-15 03:26:37', 10, 16);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-06-03 19:52:19', 18, 12);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-06-11 15:50:54', 14, 23);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Yoga Class', '2025-05-31 21:08:44', 8, 12);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-06-01 10:06:35', 5, 20);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Yoga Class', '2025-05-14 00:39:48', 12, 22);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Yoga Class', '2025-06-08 07:15:59', 3, 29);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-05-30 05:32:40', 10, 18);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-06-01 20:07:35', 10, 28);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Zumba Class', '2025-05-26 05:48:21', 11, 30);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Zumba Class', '2025-05-22 23:06:35', 19, 26);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Zumba Class', '2025-05-15 08:23:05', 9, 11);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('Yoga Class', '2025-05-21 17:33:23', 1, 30);
INSERT INTO Classes (name, schedule_time, trainer_id, capacity) VALUES ('HIIT Class', '2025-05-23 02:07:55', 20, 29);
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (9, 3, '2025-05-07');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (18, 4, '2025-05-07');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (18, 7, '2025-05-05');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (8, 20, '2025-05-08');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (14, 10, '2025-05-11');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (8, 13, '2025-05-03');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (14, 5, '2025-05-07');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (18, 9, '2025-05-07');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (11, 18, '2025-05-08');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (20, 1, '2025-05-12');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (1, 3, '2025-05-07');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (3, 2, '2025-05-06');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (1, 9, '2025-05-10');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (16, 7, '2025-05-12');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (2, 18, '2025-05-07');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (14, 16, '2025-05-09');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (7, 4, '2025-05-09');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (2, 3, '2025-05-06');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (5, 14, '2025-05-09');
INSERT INTO Class_Registrations (member_id, class_id, registration_date) VALUES (17, 20, '2025-05-07');
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (16, 14, 30);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (15, 19, 15);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (3, 7, 10);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (14, 15, 10);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (5, 7, 10);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (15, 17, 20);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (11, 13, 15);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (2, 12, 10);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (10, 18, 10);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (14, 20, 30);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (18, 8, 30);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (5, 1, 20);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (12, 10, 15);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (8, 15, 15);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (4, 5, 15);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (7, 11, 15);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (3, 19, 30);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (10, 2, 10);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (14, 13, 20);
INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes) VALUES (2, 8, 15);
INSERT INTO Users (username, password_hash, role) VALUES ('maryhenry', 'aaa88312f4f495e71fb550b905030d8a89112e1af512e8db02678a1436fc4565', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('duranderrick', 'afd65fa249227ca44c3fbed51223820732489ec255a8ed028144c9b059a9e6b8', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('grichardson', '2b8ecdd73e0a07668fa11e15eaddd213fb48dbb67ae0552f2998a4406fe820ea', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('leecharles', '57e3f544e1ebc7f389d58adeb6a5d281e2bee3052ca1947222ce5a87da8a376b', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('tcross', 'd3506f4d07d503e7c62fa71006bbf7cf27e22e86f4439fe97f97fdc13f16b02b', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('pwright', '413c186adab401bb2adda58d410e877a42e7068213e964e08fef3d2e089bec65', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('jesussteele', '93d79be14873d4c5b56ce323c167f6d2bc2a1c54d404fccb1cbeb52a68da8b8c', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('knightjohn', 'efb905cd86bcc5a695c452406073d278faeb057141dfa7e745fc33c049c12a84', 'Admin');
INSERT INTO Users (username, password_hash, role) VALUES ('dgarcia', '6287357dd9c2a2d326ee0757debd96244a547175f71c5350cecc4a17cb49d2d0', 'Admin');
INSERT INTO Users (username, password_hash, role) VALUES ('qmiller', '40763cbf31dd3db5aef531f5165b9ea46213daa62e35450bf4981677700ed15d', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('michaelvelez', '64da56a713a2a07d7356e4c7cbabf20f4a17f4ee4cf3c00e42feedde63dc292c', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('osborneamy', '1a31d1b7ce1e2829783045319bc4645cc3e56998d66bb8cf23fcd45ea04ae0a3', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('perezcrystal', '5ba879e99830cd03a5b169ee66b6fe71465d04a03841b6a807ccec870578764e', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('stacyyu', '84225a339e4414b5859371e39a1de59fadb19f11d88646b4af9b91e038124f59', 'Admin');
INSERT INTO Users (username, password_hash, role) VALUES ('piercechristopher', '229fa7a40499b1b922ea96545f8524fe9450c027be348c8ccd029c52af3fb578', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('samanthajones', '8568311636ace9784f1707ce625cfc478bd6b0d544b5d92efc33d68a357883a8', 'Admin');
INSERT INTO Users (username, password_hash, role) VALUES ('bennettbarbara', '38bbf49915767d961f623be5ecec78e0d1b6b3ff56586ac661bdbe2664c0e353', 'Admin');
INSERT INTO Users (username, password_hash, role) VALUES ('gbonilla', 'c86cc699af0bf1770fb1668ed962702285844126fd07bb42f7624df75b039755', 'Member');
INSERT INTO Users (username, password_hash, role) VALUES ('garciadanielle', 'efd3dea1d5fa87ca4e45e0f12875bf7e99a453bc085a336c5f6ad6ba44c26e9e', 'Trainer');
INSERT INTO Users (username, password_hash, role) VALUES ('nicoleedwards', '658996ac0e7d10e599fb30ab7f914cdb0fe07b8a32403e515f4ceec9e41ea527', 'Trainer');
INSERT INTO LoginHistory (user_id, login_time) VALUES (20, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (20, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (12, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (11, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (20, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (6, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (9, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (5, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (16, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (14, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (3, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (18, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (17, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (16, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (14, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (4, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (12, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (13, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (14, NOW());
INSERT INTO LoginHistory (user_id, login_time) VALUES (7, NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (4, 'Should return fill huge recent series.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (9, 'Rich try well piece.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (12, 'Friend computer group phone red author.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (4, 'Likely arm court father.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (14, 'Help thought song decade.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (11, 'Among within question college million kitchen glass.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (16, 'Perform meet dinner.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (12, 'Charge network reason fill result price.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (7, 'Or night thank behavior clear television.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (5, 'Follow candidate five.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (10, 'Bit agree assume center party.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (17, 'Player onto create political radio.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (17, 'Enough truth it American tend beautiful send mean.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (19, 'Trade home time affect word thing space.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (3, 'Wonder service fall boy computer town tax left.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (15, 'Know hour ten television step relate benefit.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (2, 'Push attention begin boy.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (7, 'Everyone art lawyer smile.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (9, 'College dinner commercial around.', NOW());
INSERT INTO Notifications (user_id, message, scheduled_time) VALUES (16, 'Billion under democratic serious as instead.', NOW());

-- COMPLEX QUERIES --

-- 1. Most paying member by membership type (nested aggregates) -- Teerdha
SELECT *
FROM (
    SELECT m.member_id, m.name, mem.type AS membership_type, SUM(p.amount) AS total_paid,
           RANK() OVER (PARTITION BY mem.type ORDER BY SUM(p.amount) DESC) AS rnk
    FROM Members m
    JOIN Payments p ON m.member_id = p.member_id
    JOIN Memberships mem ON m.membership_id = mem.membership_id
    GROUP BY m.member_id, m.name, mem.type
) AS ranked
WHERE rnk = 1;

-- 2. Classes where > 50% of capacity is registered (percent logic) -- Teerdha
SELECT c.class_id, c.name, c.capacity, COUNT(cr.registration_id) AS registered,
       ROUND((COUNT(cr.registration_id) / c.capacity) * 100, 2) AS percent_utilized
FROM Classes c
JOIN Class_Registrations cr ON c.class_id = cr.class_id
GROUP BY c.class_id
HAVING percent_utilized > 50;

-- 3. Trainers with members above avg session count (correlated subquery) -- Teerdha
SELECT t.trainer_id, t.name, COUNT(s.session_id) AS trainer_sessions
FROM Trainers t
JOIN Sessions s ON t.trainer_id = s.trainer_id
WHERE s.member_id IN (
    SELECT member_id FROM (
        SELECT member_id, COUNT(*) AS session_count
        FROM Sessions
        GROUP BY member_id
        HAVING session_count > (
            SELECT AVG(session_count) FROM (
                SELECT COUNT(*) AS session_count
                FROM Sessions
                GROUP BY member_id
            ) AS inner_avg
        )
    ) AS high_performers
)
GROUP BY t.trainer_id;

-- 4. Members with their membership and total payment -- Yash
SELECT m.name, mem.type AS membership_type, SUM(p.amount) AS total_paid
FROM Members m
JOIN Memberships mem ON m.membership_id = mem.membership_id
JOIN Payments p ON m.member_id = p.member_id
GROUP BY m.member_id;

-- 5. Average class capacity per trainer -- Yash
SELECT t.name, AVG(c.capacity) AS avg_capacity
FROM Classes c
JOIN Trainers t ON c.trainer_id = t.trainer_id
GROUP BY t.name;

-- 6. Members who joined in the past 6 months -- Yash
SELECT name, join_date
FROM Members
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 7. Count of equipment per category -- Harshala
SELECT category, COUNT(*) AS equipment_count
FROM Equipment
GROUP BY category;

-- 8. Members and their session count -- Harshala
SELECT m.name, COUNT(s.session_id) AS session_count
FROM Members m
JOIN Sessions s ON m.member_id = s.member_id
GROUP BY m.member_id;

-- 9. Total payments by method -- Harshala
SELECT pm.method_name, SUM(p.amount) AS total
FROM Payments p
JOIN PaymentMethods pm ON p.method_id = pm.method_id
GROUP BY pm.method_name;

-- 10. Members with more than 5 sessions -- Anubhav
SELECT m.name, COUNT(s.session_id) AS total_sessions
FROM Members m
JOIN Sessions s ON m.member_id = s.member_id
GROUP BY m.member_id
HAVING total_sessions > 5;

-- 11. Most used equipment -- Anubhav
SELECT e.name, COUNT(seu.usage_id) AS usage_count
FROM Equipment e
JOIN Session_Equipment_Usage seu ON e.equipment_id = seu.equipment_id
GROUP BY e.equipment_id
ORDER BY usage_count DESC
LIMIT 5;

-- 12. Average payment per membership type -- Anubhav
SELECT mem.type, AVG(p.amount) AS avg_payment
FROM Payments p
JOIN Members m ON p.member_id = m.member_id
JOIN Memberships mem ON m.membership_id = mem.membership_id
GROUP BY mem.type;

-- 13. Members not registered in any classes -- Navya
SELECT m.name
FROM Members m
LEFT JOIN Class_Registrations cr ON m.member_id = cr.member_id
WHERE cr.member_id IS NULL;

-- 14. Trainers with no sessions -- Navya
SELECT t.name
FROM Trainers t
LEFT JOIN Sessions s ON t.trainer_id = s.trainer_id
WHERE s.trainer_id IS NULL;

-- 15. Count of members per workout plan -- Navya
SELECT wp.name, COUNT(mwp.member_id) AS member_count
FROM Workout_Plans wp
LEFT JOIN Member_Workout_Plans mwp ON wp.plan_id = mwp.plan_id
GROUP BY wp.plan_id;

-- INDEXES --

CREATE INDEX idx_email_members ON Members(email);
CREATE INDEX idx_specialization_trainers ON Trainers(specialization);
CREATE INDEX idx_session_date ON Sessions(session_date);
CREATE INDEX idx_payment_date ON Payments(payment_date);
CREATE INDEX idx_status_workout ON Member_Workout_Plans(status);

-- PROCEDURES --

-- 1. Register new member -- Teerdha
DELIMITER //
DELIMITER //
CREATE PROCEDURE RegisterNewMember(
    IN p_name VARCHAR(100), IN p_gender ENUM('Male', 'Female', 'Other'),
    IN p_dob DATE, IN p_email VARCHAR(100), IN p_phone VARCHAR(15),
    IN p_address TEXT, IN p_join_date DATE, IN p_membership_id INT
)
BEGIN
    INSERT INTO Members (name, gender, dob, email, phone, address, join_date, membership_id)
    VALUES (p_name, p_gender, p_dob, p_email, p_phone, p_address, p_join_date, p_membership_id);
    SELECT 'Member registered successfully' AS message;
END;
//
DELIMITER ;

-- Sample call
CALL RegisterNewMember('Alice Example', 'Female', '1995-05-15', 'alek@example.com', '9876543210', '123 Wellness St', CURDATE(), 1);

-- 2. Log Payment -- Yash
DELIMITER //
CREATE PROCEDURE LogPayment(
    IN p_member_id INT, IN p_amount DECIMAL(10,2), IN p_date DATE, IN p_method INT
)
BEGIN
    INSERT INTO Payments (member_id, amount, payment_date, method_id)
    VALUES (p_member_id, p_amount, p_date, p_method);
    SELECT 'Payment logged successfully' AS message;
END;
//
DELIMITER ;

-- Sample call
CALL LogPayment(2, 199.99, CURDATE(), 2);

-- 3. Assign Workout Plan -- Teerdha
DELIMITER //
CREATE PROCEDURE AssignWorkoutPlan(
    IN p_member_id INT, IN p_plan_id INT, IN p_start DATE, IN p_end DATE
)
BEGIN
    INSERT INTO Member_Workout_Plans (member_id, plan_id, start_date, end_date, status)
    VALUES (p_member_id, p_plan_id, p_start, p_end, 'Active');
    SELECT 'Workout plan assigned successfully' AS message;
END;
//
DELIMITER ;

-- Sample call
CALL AssignWorkoutPlan(3, 4, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY));

-- 4. Register for Class -- Navya
DELIMITER //
CREATE PROCEDURE RegisterForClass(
    IN p_member_id INT, IN p_class_id INT, IN p_date DATE
)
BEGIN
    INSERT INTO Class_Registrations (member_id, class_id, registration_date)
    VALUES (p_member_id, p_class_id, p_date);
    SELECT 'Class registration successful' AS message;
END;
//
DELIMITER ;

-- Sample call
CALL RegisterForClass(2, 2, CURDATE());

-- 5. Schedule Session -- Harshala
DELIMITER //
CREATE PROCEDURE ScheduleSession(
    IN p_member_id INT, IN p_trainer_id INT, IN p_date DATE, IN p_duration INT
)
BEGIN
    INSERT INTO Sessions (member_id, trainer_id, session_date, duration_minutes)
    VALUES (p_member_id, p_trainer_id, p_date, p_duration);
    SELECT 'Session scheduled successfully' AS message;
END;
//
DELIMITER ;

-- Sample call
CALL ScheduleSession(2, 2, CURDATE(), 45);

-- 6. Update Email -- Anubhav
DELIMITER //
CREATE PROCEDURE UpdateEmail(
    IN p_member_id INT, IN p_email VARCHAR(100)
)
BEGIN
    UPDATE Members SET email = p_email WHERE member_id = p_member_id;
    SELECT CONCAT('Email updated for member ID: ', p_member_id) AS message;
END;
//
DELIMITER ;

-- Sample call
CALL UpdateEmail(2, 'def@example.com');

-- 7. Deactivate Member -- Yash
DELIMITER //
CREATE PROCEDURE DeactivateMember(
    IN p_member_id INT
)
BEGIN
    UPDATE Members SET is_active = FALSE WHERE member_id = p_member_id;
    SELECT CONCAT('Member ', p_member_id, ' deactivated') AS message;
END;
//
DELIMITER ;

-- Sample call
CALL DeactivateMember(2);

-- 8. Promote to Admin -- Harshala
DELIMITER //
CREATE PROCEDURE PromoteToAdmin(IN p_user_id INT)
BEGIN
    UPDATE Users SET role = 'Admin' WHERE user_id = p_user_id;
    SELECT CONCAT('User ', p_user_id, ' promoted to Admin') AS message;
END;
//
DELIMITER ;

-- Sample call
CALL PromoteToAdmin(2);

-- 9. Log Equipment Usage -- Navya
DELIMITER //
CREATE PROCEDURE LogEquipmentUsage(
    IN p_session_id INT, IN p_equipment_id INT, IN p_minutes INT
)
BEGIN
    INSERT INTO Session_Equipment_Usage (session_id, equipment_id, duration_minutes)
    VALUES (p_session_id, p_equipment_id, p_minutes);
    SELECT 'Equipment usage logged successfully' AS message;
END;
//
DELIMITER ;

-- Sample call
CALL LogEquipmentUsage(1, 1, 20);

-- 10. Reset User Password -- Anubhav
DELIMITER //
CREATE PROCEDURE ResetUserPassword(
    IN p_user_id INT, IN p_new_hash VARCHAR(255)
)
BEGIN
    UPDATE Users SET password_hash = p_new_hash WHERE user_id = p_user_id;
    SELECT CONCAT('Password reset for user ID: ', p_user_id) AS message;
END;
//
DELIMITER ;

-- Sample call
CALL ResetUserPassword(1, 'newsecurehash456');

-- FUNCTIONS --

-- 1. Calculate Age -- Navya
DELIMITER //
CREATE FUNCTION CalculateAge(p_dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_dob, CURDATE());
END;
//
DELIMITER ;

SELECT CalculateAge('1990-01-01') AS Age;

-- 2. Is Member Active -- Harshala
DELIMITER //
CREATE FUNCTION IsMemberActive(p_member_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE active BOOLEAN;
    SELECT is_active INTO active FROM Members WHERE member_id = p_member_id;
    RETURN active;
END;
//
DELIMITER ;

SELECT IsMemberActive(1) AS ActiveStatus;

-- 3. Get Membership Type -- Yash
DELIMITER //
CREATE FUNCTION GetMembershipType(p_member_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE typeName VARCHAR(100);
    SELECT m.type INTO typeName FROM Members mem
    JOIN Memberships m ON mem.membership_id = m.membership_id
    WHERE mem.member_id = p_member_id;
    RETURN typeName;
END;
//
DELIMITER ;

SELECT GetMembershipType(1) AS Membership;

-- 4. Total Payments -- Teerdha
DELIMITER //
CREATE FUNCTION TotalPayments(p_member_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(amount) INTO total FROM Payments WHERE member_id = p_member_id;
    RETURN IFNULL(total, 0);
END;
//
DELIMITER ;

SELECT TotalPayments(1) AS TotalPaid;

-- 5. Session Count -- Anubhav
DELIMITER //
CREATE FUNCTION SessionCount(p_member_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt FROM Sessions WHERE member_id = p_member_id;
    RETURN cnt;
END;
//
DELIMITER ;

SELECT SessionCount(1) AS Sessions;

-- TRIGGERS --

-- 1. Audit Member Insert -- Yash
DELIMITER //
CREATE TRIGGER trg_audit_member_insert
AFTER INSERT ON Members
FOR EACH ROW
BEGIN
    INSERT INTO MemberAudit (member_id, action_type, details)
    VALUES (NEW.member_id, 'INSERT', CONCAT('New member registered: ', NEW.name));
END;
//
DELIMITER ;

-- 2. Audit Trainer Insert -- Navya
DELIMITER //
CREATE TRIGGER trg_audit_trainer_insert
AFTER INSERT ON Trainers
FOR EACH ROW
BEGIN
    INSERT INTO TrainerAudit (trainer_id, action_type, details)
    VALUES (NEW.trainer_id, 'INSERT', CONCAT('New trainer registered: ', NEW.name));
END;
//
DELIMITER ;

-- 3. Prevent Negative Payments -- Teerdha
DELIMITER //
CREATE TRIGGER trg_no_negative_payment
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF NEW.amount < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Payment amount cannot be negative';
    END IF;
END;
//
DELIMITER ;

-- 4. Log Member Email Change -- Harshala
DELIMITER //
CREATE TRIGGER trg_member_email_update
AFTER UPDATE ON Members
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email THEN
        INSERT INTO MemberAudit (member_id, action_type, details)
        VALUES (NEW.member_id, 'EMAIL UPDATE', CONCAT('Email changed from ', OLD.email, ' to ', NEW.email));
    END IF;
END;
//
DELIMITER ;

-- 5. Reduce Class Capacity on Registration -- Anubhav
DELIMITER //
CREATE TRIGGER trg_class_capacity_reduce
AFTER INSERT ON Class_Registrations
FOR EACH ROW
BEGIN
    UPDATE Classes SET capacity = capacity - 1 WHERE class_id = NEW.class_id;
END;
//
DELIMITER ;

-- 6. Activate Member on Insert -- Navya
DELIMITER //
CREATE TRIGGER trg_auto_activate_member
BEFORE INSERT ON Members
FOR EACH ROW
BEGIN
    SET NEW.is_active = TRUE;
END;
//
DELIMITER ;

-- 7. Audit Payment Record -- Harshala
DELIMITER //
CREATE TRIGGER trg_payment_audit
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    INSERT INTO MemberAudit (member_id, action_type, details)
    VALUES (NEW.member_id, 'PAYMENT', CONCAT('Payment of ', NEW.amount, ' on ', NEW.payment_date));
END;
//
DELIMITER ;

-- 8. Track Equipment Usage -- Anubhav
DELIMITER //
CREATE TRIGGER trg_track_equipment_status
AFTER INSERT ON Session_Equipment_Usage
FOR EACH ROW
BEGIN
    UPDATE Equipment SET status = 'In Maintenance'
    WHERE equipment_id = NEW.equipment_id AND status = 'Available';
END;
//
DELIMITER ;

-- 9. Prevent Duplicate Emails -- Yash
DELIMITER //
CREATE TRIGGER trg_unique_email
BEFORE INSERT ON Members
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Members WHERE email = NEW.email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate email detected';
    END IF;
END;
//
DELIMITER ;

-- 10. Auto Log Login on User Creation -- Teerdha
DELIMITER //
CREATE TRIGGER trg_auto_login_history
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO LoginHistory (user_id) VALUES (NEW.user_id);
END;
//
DELIMITER ;

SHOW TRIGGERS;



