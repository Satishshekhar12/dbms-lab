-- 1. Retrieve the names of all instructors who teach at least one course in the 'Computer Science' department.
SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Computer Science';

-- 2. List all students who have taken at least one course in 'Fall' and 'Spring' semesters in the same year.
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t1 ON s.ID = t1.ID
JOIN takes t2 ON s.ID = t2.ID
WHERE t1.semester = 'Fall' AND t2.semester = 'Spring' AND t1.year = t2.year;

-- 3. Find all classrooms that have a capacity of more than 100 but are not assigned to any section.
SELECT c.building, c.room_number
FROM classroom c
LEFT JOIN section s ON c.building = s.building AND c.room_number = s.room_number
WHERE c.capacity > 100 AND s.course_id IS NULL;

-- 4. Display all courses along with their prerequisites, including courses that have no prerequisites.
SELECT c.course_id, c.title, p.prereq_id
FROM course c
LEFT JOIN prereq p ON c.course_id = p.course_id;

-- 5. Retrieve the list of instructors who have never taught a course.
SELECT i.name
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
WHERE t.course_id IS NULL;

-- 6. Find the total budget allocated to all departments that have at least one instructor earning more than ₹100,000.
SELECT SUM(d.budget)
FROM department d
WHERE d.dept_name IN (
    SELECT DISTINCT i.dept_name
    FROM instructor i
    WHERE i.salary > 100000
);

-- 7. Find the average salary of instructors grouped by department but only include departments with more than 5 instructors.
SELECT i.dept_name, AVG(i.salary) AS avg_salary
FROM instructor i
GROUP BY i.dept_name
HAVING COUNT(i.ID) > 5;

-- 8. Find the total number of students enrolled in each course for every semester, and sort by semester and number of students (descending).
SELECT t.course_id, t.semester, t.year, COUNT(t.ID) AS student_count
FROM takes t
GROUP BY t.course_id, t.semester, t.year
ORDER BY t.semester, student_count DESC;

-- 9. Determine which department has the highest average course credit.
SELECT c.dept_name
FROM course c
GROUP BY c.dept_name
ORDER BY AVG(c.credits) DESC
FETCH FIRST 1 ROWS ONLY;

-- 10. Find the top 3 courses with the most students enrolled across all semesters.
SELECT t.course_id, COUNT(t.ID) AS student_count
FROM takes t
GROUP BY t.course_id
ORDER BY student_count DESC
FETCH FIRST 3 ROWS ONLY;

-- 11. Find all students who have taken every course taught by the instructor 'John Doe'.
SELECT DISTINCT s.ID, s.name
FROM student s
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM teaches t
    JOIN course c ON t.course_id = c.course_id
    JOIN instructor i ON t.ID = i.ID
    WHERE i.name = 'John Doe'
    MINUS
    SELECT t2.course_id FROM takes t2 WHERE t2.ID = s.ID
);

-- 12. Retrieve the names of students who have the same name as their advisor.
SELECT s.name
FROM student s
JOIN advisor a ON s.ID = a.s_ID
JOIN instructor i ON a.i_ID = i.ID
WHERE s.name = i.name;

-- 13. Find all instructors who have taught at least one course that they did not belong to the department of.
SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE i.dept_name <> c.dept_name;

-- 14. List all students who have taken a course in a classroom that has a capacity less than the number of students enrolled.
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id
JOIN classroom c ON sec.building = c.building AND sec.room_number = c.room_number
GROUP BY s.ID, s.name, c.capacity
HAVING COUNT(t.ID) > c.capacity;

-- 15. Find students who have taken every course offered by their department.
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN department d ON s.dept_name = d.dept_name
WHERE NOT EXISTS (
    SELECT c.course_id FROM course c WHERE c.dept_name = s.dept_name
    MINUS
    SELECT t.course_id FROM takes t WHERE t.ID = s.ID
);

-- 16. Identify the department(s) with the largest number of distinct courses offered.
SELECT c.dept_name
FROM course c
GROUP BY c.dept_name
ORDER BY COUNT(DISTINCT c.course_id) DESC
FETCH FIRST 1 ROWS ONLY;

-- 17. Find students who have taken a course but have not received a grade.
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.grade IS NULL;

-- 18. Retrieve the details of instructors who have the exact same salary as another instructor.
SELECT i1.*
FROM instructor i1
JOIN instructor i2 ON i1.salary = i2.salary AND i1.ID <> i2.ID;

-- 19. Identify all courses that have prerequisites, but the prerequisite itself has no prerequisite.
SELECT DISTINCT c.course_id
FROM course c
JOIN prereq p ON c.course_id = p.course_id
WHERE p.prereq_id NOT IN (SELECT course_id FROM prereq);

-- 20. Find all students who have taken courses in every semester (Fall, Winter, Spring, Summer) at least once.
SELECT DISTINCT s.ID, s.name
FROM student s
WHERE NOT EXISTS (
    SELECT DISTINCT semester FROM section
    MINUS
    SELECT DISTINCT t.semester FROM takes t WHERE t.ID = s.ID
);

-- 20. Find all students who have taken courses in every semester (Fall, Winter, Spring, Summer) at least once.
SELECT DISTINCT s.ID, s.name
FROM student s
WHERE NOT EXISTS (
    SELECT DISTINCT semester FROM section
    MINUS
    SELECT DISTINCT t.semester FROM takes t WHERE t.ID = s.ID
);

-- 21. Find all prerequisite chains for a given course (i.e., if A is a prerequisite for B, and B is a prerequisite for C, return A → B → C).
WITH RECURSIVE PrereqChain(course_id, prereq_id, path) AS (
    SELECT course_id, prereq_id, CAST(prereq_id AS VARCHAR(100))
    FROM prereq
    UNION ALL
    SELECT p.course_id, pr.prereq_id, pc.path || ' → ' || pr.prereq_id
    FROM prereq pr
    JOIN PrereqChain pc ON pr.course_id = pc.prereq_id
)
SELECT * FROM PrereqChain;

-- 22. List all courses that have at least two levels of prerequisites (i.e., a prerequisite has another prerequisite).
SELECT DISTINCT c.course_id
FROM course c
JOIN prereq p1 ON c.course_id = p1.course_id
JOIN prereq p2 ON p1.prereq_id = p2.course_id;

-- 23. Find the shortest prerequisite chain for any course that eventually leads to a specific course, say 'CS101'.
WITH RECURSIVE PrereqPath(course_id, prereq_id, depth) AS (
    SELECT course_id, prereq_id, 1 FROM prereq
    UNION ALL
    SELECT p.course_id, pr.prereq_id, pp.depth + 1
    FROM prereq pr
    JOIN PrereqPath pp ON pr.course_id = pp.prereq_id
)
SELECT * FROM PrereqPath WHERE course_id = 'CS101' ORDER BY depth ASC FETCH FIRST 1 ROW ONLY;

-- 24. Identify students who have taken a course whose prerequisite they have never taken.
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN prereq p ON t.course_id = p.course_id
WHERE p.prereq_id NOT IN (SELECT t2.course_id FROM takes t2 WHERE t2.ID = s.ID);

-- 25. Find all instructors who have taught a course that has another course as a prerequisite.
SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN prereq p ON t.course_id = p.course_id;

-- 26. Find all students who have the same total credits as another student in a different department.
SELECT s1.ID, s1.name, s1.dept_name
FROM student s1
JOIN student s2 ON s1.total_credits = s2.total_credits AND s1.dept_name <> s2.dept_name;

-- 27. Identify instructors who have the highest salary in their department but still earn less than the highest salary in another department.
WITH DeptMaxSalary AS (
    SELECT dept_name, MAX(salary) AS max_salary
    FROM instructor
    GROUP BY dept_name
)
SELECT i.name, i.salary, i.dept_name
FROM instructor i
JOIN DeptMaxSalary d ON i.dept_name = d.dept_name
WHERE i.salary = d.max_salary
AND i.salary < (SELECT MAX(salary) FROM instructor WHERE dept_name <> i.dept_name);

-- 28. Retrieve students who have taken more than one course but have failed at least half of them (assuming grade 'F' is failing).
SELECT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
GROUP BY s.ID, s.name
HAVING COUNT(t.course_id) > 1 AND SUM(CASE WHEN t.grade = 'F' THEN 1 ELSE 0 END) >= COUNT(t.course_id) / 2;

