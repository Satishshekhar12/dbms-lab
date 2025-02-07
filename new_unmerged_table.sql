------------------
-- Departments (10+)
------------------
INSERT INTO department (dept_name, building, budget) VALUES
('Computer Science', 'Taylor', 2000000),
('Mathematics', 'Watson', 1500000),
('Biology', 'Newton', 1200000),
('Physics', 'Einstein', 1000000),
('Chemistry', 'Curie', 900000),
('History', 'Herodotus', 800000),
('Economics', 'Keynes', 1300000),
('Psychology', 'Freud', 700000),
('Engineering', 'Edison', 1800000),
('Philosophy', 'Socrates', 600000);

------------------
-- Classrooms (10+)
------------------
INSERT INTO classroom (building, room_number, capacity) VALUES
('Taylor', '101', 60), ('Taylor', '102', 70), ('Taylor', '103', 80),
('Watson', '201', 50), ('Watson', '202', 55),
('Newton', '301', 40), ('Newton', '302', 45),
('Einstein', '401', 30), ('Einstein', '402', 35),
('Curie', '501', 100), ('Herodotus', '601', 200);

------------------
-- Instructors (10+)
------------------
INSERT INTO instructor (ID, name, dept_name, salary) VALUES
('I1', 'Dr. Smith', 'Computer Science', 75000),
('I2', 'Dr. Johnson', 'Computer Science', 80000),
('I3', 'Dr. Euler', 'Mathematics', 70000),
('I4', 'Dr. Darwin', 'Biology', 65000),
('I5', 'Dr. Tesla', 'Physics', 72000),
('I6', 'Dr. Curie', 'Chemistry', 68000),
('I7', 'Dr. Keynes', 'Economics', 71000),
('I8', 'Dr. Freud', 'Psychology', 63000),
('I9', 'Dr. Edison', 'Engineering', 85000),
('I10', 'Dr. Socrates', 'Philosophy', 60000),
('I11', 'Dr. NoDept', NULL, 50000); -- Instructor with no department

------------------
-- Courses (10+)
------------------
INSERT INTO course (course_id, title, dept_name, credits) VALUES
('CS101', 'Intro to CS', 'Computer Science', 3),
('CS201', 'Data Structures', 'Computer Science', 4),
('CS301', 'Algorithms', 'Computer Science', 4),
('MATH101', 'Calculus I', 'Mathematics', 3),
('MATH201', 'Linear Algebra', 'Mathematics', 4),
('BIO101', 'Biology Basics', 'Biology', 3),
('BIO201', 'Genetics', 'Biology', 4),
('PHY101', 'Physics I', 'Physics', 3),
('PHY201', 'Quantum Physics', 'Physics', 4),
('CHEM101', 'General Chemistry', 'Chemistry', 3),
('ECON101', 'Microeconomics', 'Economics', 3),
('PSY101', 'Intro to Psychology', 'Psychology', 3),
('ENG101', 'Engineering Basics', 'Engineering', 4),
('PHIL101', 'Ethics', 'Philosophy', 3),
('HIST101', 'World History', 'History', 3);

------------------
-- Prerequisites (10+)
------------------
INSERT INTO prereq (course_id, prereq_id) VALUES
('CS201', 'CS101'),
('CS301', 'CS201'),
('MATH201', 'MATH101'),
('BIO201', 'BIO101'),
('PHY201', 'PHY101'),
('CS301', 'MATH201'), -- Extra prerequisite for query 34 (multiple prereqs)
('ENG101', 'MATH101'),
('PHY201', 'MATH201'),
('CS201', 'MATH101'),
('CS301', 'PHY101');

------------------
-- Students (10+)
------------------
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES
('S1', 'Alice', 'Computer Science', 150),
('S2', 'Bob', 'Mathematics', 120),
('S3', 'Charlie', 'Biology', 110),
('S4', 'David', 'Physics', 100),
('S5', 'Eve', 'Chemistry', 90),
('S6', 'Frank', 'Economics', 130),
('S7', 'Grace', 'Psychology', 80),
('S8', 'Henry', 'Engineering', 140),
('S9', 'Ivy', 'Philosophy', 70),
('S10', 'Jack', 'History', 85),
('S11', 'Karen', 'Computer Science', 160), -- For query 31 (takes all CS courses)
('S12', 'Liam', 'Computer Science', 155);

------------------
-- Sections (10+)
------------------
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES
-- Computer Science
('CS101', '1', 'Fall', 2022, 'Taylor', '101', 'TS1'),
('CS101', '2', 'Spring', 2023, 'Taylor', '102', 'TS2'),
('CS201', '1', 'Spring', 2023, 'Taylor', '103', 'TS3'),
('CS301', '1', 'Fall', 2023, 'Taylor', '101', 'TS4'),
-- Mathematics
('MATH101', '1', 'Fall', 2022, 'Watson', '201', 'TS5'),
('MATH201', '1', 'Spring', 2023, 'Watson', '202', 'TS6'),
-- Biology
('BIO101', '1', 'Fall', 2022, 'Newton', '301', 'TS7'),
('BIO201', '1', 'Spring', 2023, 'Newton', '302', 'TS8'),
-- Physics
('PHY101', '1', 'Spring', 2023, 'Einstein', '401', 'TS9'),
('PHY201', '1', 'Fall', 2023, 'Einstein', '402', 'TS10'),
-- Other Departments
('CHEM101', '1', 'Fall', 2022, 'Curie', '501', 'TS11'),
('ECON101', '1', 'Spring', 2023, 'Keynes', '201', 'TS12'),
('PSY101', '1', 'Fall', 2022, 'Freud', '301', 'TS13'),
('ENG101', '1', 'Spring', 2023, 'Edison', '401', 'TS14'),
('PHIL101', '1', 'Fall', 2022, 'Socrates', '501', 'TS15'),
('HIST101', '1', 'Spring', 2023, 'Herodotus', '601', 'TS16');

------------------
-- Teaches (10+)
------------------
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES
-- Computer Science
('I1', 'CS101', '1', 'Fall', 2022),
('I2', 'CS101', '2', 'Spring', 2023),
('I1', 'CS201', '1', 'Spring', 2023),
('I2', 'CS301', '1', 'Fall', 2023),
-- Mathematics
('I3', 'MATH101', '1', 'Fall', 2022),
('I3', 'MATH201', '1', 'Spring', 2023),
-- Biology
('I4', 'BIO101', '1', 'Fall', 2022),
('I4', 'BIO201', '1', 'Spring', 2023),
-- Physics
('I5', 'PHY101', '1', 'Spring', 2023),
('I5', 'PHY201', '1', 'Fall', 2023),
-- Other Departments
('I6', 'CHEM101', '1', 'Fall', 2022),
('I7', 'ECON101', '1', 'Spring', 2023),
('I8', 'PSY101', '1', 'Fall', 2022),
('I9', 'ENG101', '1', 'Spring', 2023),
('I10', 'PHIL101', '1', 'Fall', 2022);

------------------
-- Takes (10+)
------------------
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES
-- Alice (S1): Enrolled in Fall 2022 and Spring 2023
('S1', 'CS101', '1', 'Fall', 2022, 'A'),
('S1', 'CS201', '1', 'Spring', 2023, 'B'),
('S1', 'MATH101', '1', 'Fall', 2022, 'A'),
-- Bob (S2): Enrolled in Fall 2022 and Spring 2023
('S2', 'MATH101', '1', 'Fall', 2022, 'B'),
('S2', 'MATH201', '1', 'Spring', 2023, 'A'),
('S2', 'PHY101', '1', 'Spring', 2023, 'C'),
-- Charlie (S3): Enrolled in Fall 2022 and Spring 2023
('S3', 'BIO101', '1', 'Fall', 2022, 'A'),
('S3', 'BIO201', '1', 'Spring', 2023, 'B'),
-- David (S4): Enrolled in Spring 2023
('S4', 'PHY101', '1', 'Spring', 2023, 'A'),
-- Eve (S5): Enrolled in Fall 2022
('S5', 'CHEM101', '1', 'Fall', 2022, 'B'),
-- Frank (S6): Enrolled in Spring 2023
('S6', 'ECON101', '1', 'Spring', 2023, 'A'),
-- Grace (S7): Enrolled in Fall 2022
('S7', 'PSY101', '1', 'Fall', 2022, 'C'),
-- Henry (S8): Enrolled in Spring 2023
('S8', 'ENG101', '1', 'Spring', 2023, 'B'),
-- Ivy (S9): Enrolled in Fall 2022
('S9', 'PHIL101', '1', 'Fall', 2022, 'A'),
-- Jack (S10): Enrolled in Spring 2023
('S10', 'HIST101', '1', 'Spring', 2023, 'B'),
-- Karen (S11): Takes ALL CS courses (for query 31)
('S11', 'CS101', '1', 'Fall', 2022, 'A'),
('S11', 'CS201', '1', 'Spring', 2023, 'A'),
('S11', 'CS301', '1', 'Fall', 2023, 'A'),
-- Liam (S12): Takes ALL CS courses (for query 31)
('S12', 'CS101', '1', 'Fall', 2022, 'A'),
('S12', 'CS201', '1', 'Spring', 2023, 'A'),
('S12', 'CS301', '1', 'Fall', 2023, 'A'),
-- Additional enrollments for query 22 (students in both semesters)
('S1', 'PHY101', '1', 'Spring', 2023, 'B'), -- Alice in Spring
('S3', 'CS101', '1', 'Fall', 2022, 'C'), -- Charlie in Fall
('S6', 'PSY101', '1', 'Fall', 2022, 'A'), -- Frank in Fall
('S8', 'MATH101', '1', 'Fall', 2022, 'B'); -- Henry in Fall

------------------
-- Advisors (10+)
------------------
INSERT INTO advisor (s_ID, i_ID) VALUES
('S1', 'I1'), ('S2', 'I3'), ('S3', 'I4'),
('S4', 'I5'), ('S5', 'I6'), ('S6', 'I7'),
('S7', 'I8'), ('S8', 'I9'), ('S9', 'I10');
-- S10, S11, S12 have no advisors (for query 16)

------------------
-- Time Slots (10+)
------------------
INSERT INTO time_slot (time_slot_id, day, start_hr, start_min, end_hr, end_min) VALUES
('TS1', 'M', 9, 0, 10, 0),
('TS2', 'T', 10, 0, 11, 0),
('TS3', 'W', 11, 0, 12, 0),
('TS4', 'TH', 12, 0, 13, 0),
('TS5', 'F', 13, 0, 14, 0),
('TS6', 'M', 14, 0, 15, 0),
('TS7', 'T', 15, 0, 16, 0),
('TS8', 'W', 16, 0, 17, 0),
('TS9', 'TH', 8, 0, 9, 0),
('TS10', 'F', 17, 0, 18, 0);
