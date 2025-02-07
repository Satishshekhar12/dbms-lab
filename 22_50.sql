23-
INSERT INTO section (COURSE_ID, SEC_ID, SEMESTER, YEAR, BUILDING, ROOM_NUMBER, TIME_SLOT_ID)
VALUES ('MA700', '008', 'Fall', 2025, 'East', '203', 'T1');
24-
SELECT course_id FROM course WHERE course_id NOT IN (SELECT course_id FROM prereq);

25-
SELECT debt_name, AVG(tot_cred) AS avg_credits FROM student GROUP BY debt_name;

26-
  
  SELECT DISTINCT student.name 
FROM student 
JOIN takes ON student.ID = takes.ID 
JOIN teaches ON takes.course_id = teaches.course_id 
JOIN instructor ON teaches.ID = instructor.ID 
WHERE instructor.name = 'Dr. Mahima';

27 -   select * from section where building='main';
28-    SELECT course_id FROM course WHERE course_id NOT IN (SELECT course_id FROM prereq);

29-
  SELECT DISTINCT student.name 
FROM student 
JOIN takes ON student.ID = takes.ID 
WHERE takes.grade = 'B';

30- select name from instructor 
    where id not in(select id from teaches)
    ;

31- SELECT s.name
FROM student s
WHERE NOT EXISTS (
    SELECT course_id FROM course 
    WHERE debt_name = 'Mathematics'
    MINUS
    SELECT course_id FROM takes 
    WHERE takes.ID = s.ID
);

32-

select i.name
  from instructor i
    where not exists(
    select course_id from course
    where debt_name=i.debt_name
    MINUS
    select course_id from teaches 
    where teaches.id=i.id);

33-

### 33. List all students who have taken at least one course with every instructor in their department.  
sele
select s.name from student s
where not exists(
  select id from instructor 
  where debt_name=s.debt_name
  MINUS
  select te from takes t 
  join teaches te on t.course_id=te.course_id
  where t.id=s.id
);

or

SELECT s.name 
FROM student s 
WHERE NOT EXISTS (
    SELECT i.ID 
    FROM instructor i 
    WHERE i.debt_name = s.debt_name 
    MINUS 
    SELECT t.ID se
    FROM takes t 
    JOIN teaches te ON t.course_id = te.course_id 
    WHERE t.ID = s.ID
);

34-
SELECT course_id 
FROM prereq
GROUP BY course_id 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM prereq GROUP BY course_id);


35-
SELECT s.name 
FROM student s 
JOIN takes t ON s.ID = t.ID 
GROUP BY s.name, t.course_id 
HAVING COUNT(*) > 1;






























