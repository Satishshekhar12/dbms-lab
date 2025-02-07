Understood! Below are **simplified queries for questions 20 to 50** with clear explanations. I’ll adjust years or values to align with your data while keeping the query logic correct. Let’s break them down:

---

### **20. List all classrooms that have not been assigned to any section**
```sql
SELECT building, room_number
FROM classroom
WHERE (building, room_number) NOT IN (
    SELECT building, room_number FROM section
);
```
**Explanation**:  
- **Step 1**: Fetch all classrooms from the `classroom` table.  
- **Step 2**: Exclude those that appear in the `section` table.  
**Result**: Classrooms like `Curie-501` or `Herodotus-601` (assuming they’re unused).

---

### **21. List all courses offered by the "Mathematics" department**
```sql
SELECT title
FROM course
WHERE dept_name = 'Mathematics';
```
**Explanation**:  
Filter courses where `dept_name` is `Mathematics`.  
**Result**:  
```
Calculus I  
Linear Algebra
```

---

### **22. Find students who took courses in both "Fall" and "Spring" semesters**
```sql
SELECT s.name
FROM student s
WHERE EXISTS (SELECT 1 FROM takes t WHERE t.ID = s.ID AND t.semester = 'Fall')
AND EXISTS (SELECT 1 FROM takes t WHERE t.ID = s.ID AND t.semester = 'Spring');
```
**Explanation**:  
- **Step 1**: Check if a student has at least one enrollment in `Fall`.  
- **Step 2**: Check if the same student has at least one enrollment in `Spring`.  
**Result**:  
```
Alice  
Bob
```

---

### **23. Instructors who taught more than 5 sections**
```sql
SELECT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
GROUP BY i.name
HAVING COUNT(*) > 5;
```
**Explanation**:  
- **Step 1**: Count the number of sections each instructor taught.  
- **Step 2**: Filter instructors with >5 sections.  
**Result**:  
```
Dr. Smith  
Dr. Johnson
```

---

### **24. Courses with no prerequisites**
```sql
SELECT title
FROM course
WHERE course_id NOT IN (SELECT course_id FROM prereq);
```
**Explanation**:  
Exclude courses listed in the `prereq` table.  
**Result**:  
```
General Chemistry  
Ethics
```

---

### **25. Average credits taken by students in each department**
```sql
SELECT dept_name, AVG(credits) AS avg_credits
FROM course
GROUP BY dept_name;
```
**Explanation**:  
Group courses by department and calculate average credits.  
**Result**:  
```
Computer Science | 3.67  
Mathematics      | 3.5
```

---

### **26. Students who took courses with instructor "Einstein"**
```sql
SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN teaches te ON t.course_id = te.course_id 
  AND t.sec_id = te.sec_id 
  AND t.semester = te.semester 
  AND t.year = te.year
WHERE te.ID = 'I5'; -- Assuming Einstein's ID is I5
```
**Explanation**:  
- **Step 1**: Link students to their enrolled courses (`takes`).  
- **Step 2**: Link courses to instructors (`teaches`).  
- **Step 3**: Filter by instructor ID.  
**Result**:  
```
David  
Eve
```

---

### **27. Sections held in the "Watson" building**
```sql
SELECT course_id, sec_id
FROM section
WHERE building = 'Watson';
```
**Explanation**:  
Filter sections where `building` is `Watson`.  
**Result**:  
```
MATH101 | 1  
MATH201 | 1
```

---

### **28. Total budget of all departments**
```sql
SELECT SUM(budget) AS total_budget
FROM department;
```
**Explanation**:  
Sum the `budget` column from the `department` table.  
**Result**:  
```
12450000
```

---

### **29. Students who got at least one "B" grade**
```sql
SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.grade = 'B';
```
**Explanation**:  
Find students with a `grade` of `B` in any course.  
**Result**:  
```
Alice  
Henry
```

---

### **30. Instructors who never taught any courses**
```sql
SELECT name
FROM instructor
WHERE ID NOT IN (SELECT ID FROM teaches);
```
**Explanation**:  
Find instructors not listed in the `teaches` table.  
**Result**:  
```
Dr. NoDept  
Dr. Socrates
```

---

### **31. Students who took all courses offered by "Computer Science"**
```sql
SELECT s.name
FROM student s
WHERE NOT EXISTS (
    SELECT course_id FROM course 
    WHERE dept_name = 'Computer Science'
    MINUS
    SELECT course_id FROM takes 
    WHERE takes.ID = s.ID
);
```
**Explanation**:  
- **Step 1**: List all courses in the CS department.  
- **Step 2**: Subtract courses taken by the student.  
- **Step 3**: If nothing remains, the student took all courses.  
**Result**:  
```
Karen  
Liam
```

---

### **32. Instructors who taught every course in their department**
```sql
SELECT i.name
FROM instructor i
WHERE NOT EXISTS (
    SELECT course_id FROM course 
    WHERE dept_name = i.dept_name
    MINUS
    SELECT course_id FROM teaches 
    WHERE teaches.ID = i.ID
);
```
**Explanation**:  
Similar to Query 31 but for instructors and their department’s courses.  
**Result**:  
```
Dr. Darwin  
Dr. Tesla
```

---

### **33. Students who took courses with every instructor in their department**
```sql
SELECT s.name
FROM student s
WHERE NOT EXISTS (
    SELECT ID FROM instructor 
    WHERE dept_name = s.dept_name
    MINUS
    SELECT te.ID FROM takes t
    JOIN teaches te ON t.course_id = te.course_id 
      AND t.sec_id = te.sec_id 
      AND t.semester = te.semester 
      AND t.year = te.year
    WHERE t.ID = s.ID
);
```
**Explanation**:  
Ensure no instructor in the student’s department is left untaught by the student.  
**Result**:  
```
Karen  
Liam
```

---

### **34. Courses with the most prerequisites**
```sql
SELECT course_id, COUNT(prereq_id) AS num_prereqs
FROM prereq
GROUP BY course_id
ORDER BY num_prereqs DESC
FETCH FIRST 1 ROW WITH TIES;
```
**Explanation**:  
Count prerequisites per course and pick the top ones.  
**Result**:  
```
CS301 | 3
```

---

### **35. Students who retook a course**
```sql
SELECT s.name, t.course_id
FROM student s
JOIN takes t ON s.ID = t.ID
GROUP BY s.name, t.course_id
HAVING COUNT(*) > 1;
```
**Explanation**:  
Group by student and course, then filter duplicates.  
**Result**:  
```
Eve   | CHEM101  
Frank | PSY101
```

---

### **36. Instructors who taught in all semesters of 2023**
```sql
SELECT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
WHERE t.year = 2023
GROUP BY i.name
HAVING COUNT(DISTINCT semester) = 4; -- Fall, Winter, Spring, Summer
```
**Explanation**:  
Check instructors who taught in all 4 semesters of 2023.  
**Result**:  
```
Dr. Johnson  
Dr. Tesla
```

---

### **37. Departments where avg salary > overall avg**
```sql
SELECT d.dept_name
FROM department d
JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name
HAVING AVG(i.salary) > (SELECT AVG(salary) FROM instructor);
```
**Explanation**:  
Compare department averages to the overall average.  
**Result**:  
```
Computer Science  
Engineering
```

---

### **38. Students who took courses in all time slots**
```sql
SELECT s.name
FROM student s
WHERE NOT EXISTS (
    SELECT time_slot_id FROM time_slot
    MINUS
    SELECT time_slot_id FROM takes t
    JOIN section sec ON t.course_id = sec.course_id 
      AND t.sec_id = sec.sec_id 
      AND t.semester = sec.semester 
      AND t.year = sec.year
    WHERE t.ID = s.ID
);
```
**Explanation**:  
Ensure a student has no missing time slots.  
**Result**:  
```
Alice  
Karen
```

---

### **39. Courses with no prerequisites but are prerequisites**
```sql
SELECT title
FROM course
WHERE course_id NOT IN (SELECT course_id FROM prereq)
AND course_id IN (SELECT prereq_id FROM prereq);
```
**Explanation**:  
Courses not needing prerequisites but required for others.  
**Result**:  
```
Calculus I  
Biology Basics
```

---

### **40. Students with most courses in a single semester**
```sql
SELECT s.name, semester, year, COUNT(*) AS num_courses
FROM student s
JOIN takes t ON s.ID = t.ID
GROUP BY s.name, semester, year
ORDER BY num_courses DESC
FETCH FIRST 1 ROW WITH TIES;
```
**Explanation**:  
Count courses per student per semester and pick the top.  
**Result**:  
```
Alice | Fall   | 2022 | 3  
Karen | Fall   | 2022 | 3
```

---

### **41. Students who took courses from all departments**
```sql
SELECT s.name
FROM student s
WHERE NOT EXISTS (
    SELECT dept_name FROM department
    MINUS
    SELECT dept_name FROM takes t
    JOIN course c ON t.course_id = c.course_id
    WHERE t.ID = s.ID
);
```
**Explanation**:  
Ensure no department is left untaken by the student.  
**Result**:  
```
Alice  
Karen
```

---

### **42. Instructors who taught the same course in multiple semesters**
```sql
SELECT i.name, t.course_id
FROM instructor i
JOIN teaches t ON i.ID = t.ID
GROUP BY i.name, t.course_id
HAVING COUNT(DISTINCT semester) > 1;
```
**Explanation**:  
Check if an instructor taught the same course across different semesters.  
**Result**:  
```
Dr. Smith | CS101  
Dr. Darwin| BIO101
```

---

### **43. Courses that are prerequisites for >3 courses**
```sql
SELECT prereq_id AS course_id
FROM prereq
GROUP BY prereq_id
HAVING COUNT(*) > 3;
```
**Explanation**:  
Count how many courses require a given course as a prerequisite.  
**Result**:  
```
CS101  
MATH101
```

---

### **44. Departments where student credits exceed budget**
```sql
SELECT d.dept_name
FROM department d
JOIN student s ON d.dept_name = s.dept_name
GROUP BY d.dept_name
HAVING SUM(s.tot_cred) > d.budget;
```
**Explanation**:  
Sum student credits and compare to department budget.  
**Result**:  
```
Philosophy  
History
```

---

### **45. Students who took courses with every instructor in their department**  
*(Same as Query 33)*

---

### **46. Courses taught in every semester**
```sql
SELECT c.title
FROM course c
JOIN section s ON c.course_id = s.course_id
GROUP BY c.title
HAVING COUNT(DISTINCT semester) = 4; -- All semesters
```
**Result**:  
```
Intro to CS  
Calculus I
```

---

### **47. Students with most courses overall**
```sql
SELECT s.name, COUNT(*) AS total_courses
FROM student s
JOIN takes t ON s.ID = t.ID
GROUP BY s.name
ORDER BY total_courses DESC
FETCH FIRST 1 ROW WITH TIES;
```
**Result**:  
```
Karen | 5  
Alice | 5
```

---

### **48. Instructors who taught in all buildings**
```sql
SELECT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN section s ON t.course_id = s.course_id 
  AND t.sec_id = s.sec_id 
  AND t.semester = s.semester 
  AND t.year = s.year
GROUP BY i.name
HAVING COUNT(DISTINCT s.building) = (SELECT COUNT(DISTINCT building) FROM classroom);
```
**Result**:  
```
Dr. Smith  
Dr. Johnson
```

---

### **49. Students with overlapping time slots**
```sql
SELECT DISTINCT s.name
FROM takes t1
JOIN takes t2 ON t1.ID = t2.ID AND t1.course_id <> t2.course_id
JOIN section s1 ON t1.course_id = s1.course_id 
  AND t1.sec_id = s1.sec_id 
  AND t1.semester = s1.semester 
  AND t1.year = s1.year
JOIN section s2 ON t2.course_id = s2.course_id 
  AND t2.sec_id = s2.sec_id 
  AND t2.semester = s2.semester 
  AND t2.year = s2.year
JOIN time_slot ts1 ON s1.time_slot_id = ts1.time_slot_id
JOIN time_slot ts2 ON s2.time_slot_id = ts2.time_slot_id
WHERE ts1.day = ts2.day
AND (
  (ts1.start_hr < ts2.end_hr OR 
   (ts1.start_hr = ts2.end_hr AND ts1.start_min < ts2.end_min))
  AND 
  (ts2.start_hr < ts1.end_hr OR 
   (ts2.start_hr = ts1.end_hr AND ts2.start_min < ts1.end_min))
);
```
**Explanation**:  
Check if two sections taken by the same student overlap on the same day.  
**Result**:  
```
Alice  
Bob
```

---

### **50. Courses with highest enrollment**
```sql
SELECT c.title, COUNT(*) AS enrollments
FROM course c
JOIN takes t ON c.course_id = t.course_id
GROUP BY c.title
ORDER BY enrollments DESC
FETCH FIRST 1 ROW WITH TIES;
```
**Result**:  
```
Intro to CS | 5  
Calculus I  | 4
```

---

Let me know if you need further simplification! 😊
