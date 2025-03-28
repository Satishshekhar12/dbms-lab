CREATE TABLE Employee (
    Fname VARCHAR(30),
    Mname VARCHAR(30),
    Lname VARCHAR(30) NOT NULL,
    Ssn NUMBER PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(30),
    Gender CHAR(1),
    Salary NUMBER(10,2),
    Super_Ssn NUMBER,
    Dept_num NUMBER NOT NULL REFERENCES Departments(Dept_num) ON DELETE CASCADE
);

CREATE TABLE Departments (
    Dept_num NUMBER PRIMARY KEY,
    Dept_name VARCHAR(30) UNIQUE NOT NULL,
    Mgr_Ssn NUMBER,
    Mgr_startdate NUMBER
);

CREATE TABLE Department_Location (
    Dept_num NUMBER NOT NULL REFERENCES Departments(Dept_num) ON DELETE CASCADE,
    Location VARCHAR(30),
    PRIMARY KEY (Dept_num, Location)
);

CREATE TABLE Project (
    Proj_num NUMBER PRIMARY KEY,
    Proj_name VARCHAR(30),
    Proj_location VARCHAR(30),
    Dept_num NUMBER NOT NULL REFERENCES Departments(Dept_num) ON DELETE CASCADE
);

CREATE TABLE Employee_Project (
    Ssn NUMBER NOT NULL REFERENCES Employee(Ssn) ON DELETE CASCADE,
    Proj_num NUMBER NOT NULL REFERENCES Project(Proj_num) ON DELETE CASCADE,
    Hours NUMBER,
    PRIMARY KEY (Ssn, Proj_num)
);

CREATE TABLE Dependent (
    Ssn NUMBER NOT NULL REFERENCES Employee(Ssn) ON DELETE CASCADE,
    Dept_name VARCHAR(30) NOT NULL REFERENCES Departments(Dept_name) ON DELETE CASCADE,
    Gender CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(30),
    PRIMARY KEY (Ssn, Dept_name)
);
-- Insert Employee data with Bdate as number (YYYY format)
INSERT INTO Employee VALUES ('John', 'A', 'Doe', 101, 1990, 'New York', 'M', 50000, NULL, 1);
INSERT INTO Employee VALUES ('Jane', 'B', 'Smith', 102, 1992, 'Los Angeles', 'F', 60000, 101, 2);
INSERT INTO Employee VALUES ('Alice', 'C', 'Brown', 103, 1993, 'Chicago', 'F', 55000, 101, 3);
INSERT INTO Employee VALUES ('Bob', 'D', 'Johnson', 104, 1994, 'Houston', 'M', 52000, 103, 4);
INSERT INTO Employee VALUES ('Charlie', 'E', 'White', 105, 1995, 'Phoenix', 'M', 58000, 104, 5);
INSERT INTO Employee VALUES ('David', 'F', 'Clark', 106, 1996, 'San Diego', 'M', 62000, 105, 6);
INSERT INTO Employee VALUES ('Emma', 'G', 'Harris', 107, 1989, 'Dallas', 'F', 63000, 106, 7);
INSERT INTO Employee VALUES ('Frank', 'H', 'Miller', 108, 1988, 'Seattle', 'M', 54000, 107, 8);
INSERT INTO Employee VALUES ('Grace', 'I', 'Davis', 109, 1987, 'Boston', 'F', 61000, 108, 9);
INSERT INTO Employee VALUES ('Henry', 'J', 'Wilson', 110, 1986, 'Austin', 'M', 59000, 109, 10);

-- Insert Departments data (Mgr_startdate as number YYYY)
INSERT INTO Departments VALUES (1, 'HR', 1001, 2020);
INSERT INTO Departments VALUES (2, 'IT', 1002, 2020);
INSERT INTO Departments VALUES (3, 'Finance', 1003, 2020);
INSERT INTO Departments VALUES (4, 'Marketing', 1004, 2020);
INSERT INTO Departments VALUES (5, 'Sales', 1005, 2020);
INSERT INTO Departments VALUES (6, 'Operations', 1006, 2020);
INSERT INTO Departments VALUES (7, 'Legal', 1007, 2020);
INSERT INTO Departments VALUES (8, 'Admin', 1008, 2020);
INSERT INTO Departments VALUES (9, 'R&D', 1009, 2020);
INSERT INTO Departments VALUES (10, 'Support', 1010, 2020);

-- Insert Department_Location data
INSERT INTO Department_Location VALUES (1, 'New York');
INSERT INTO Department_Location VALUES (2, 'Los Angeles');
INSERT INTO Department_Location VALUES (3, 'Chicago');
INSERT INTO Department_Location VALUES (4, 'Houston');
INSERT INTO Department_Location VALUES (5, 'Phoenix');
INSERT INTO Department_Location VALUES (6, 'San Diego');
INSERT INTO Department_Location VALUES (7, 'Dallas');
INSERT INTO Department_Location VALUES (8, 'Seattle');
INSERT INTO Department_Location VALUES (9, 'Boston');
INSERT INTO Department_Location VALUES (10, 'Austin');

-- Insert Project data
INSERT INTO Project VALUES (201, 'Project A', 'New York', 1);
INSERT INTO Project VALUES (202, 'Project B', 'Los Angeles', 2);
INSERT INTO Project VALUES (203, 'Project C', 'Chicago', 3);
INSERT INTO Project VALUES (204, 'Project D', 'Houston', 4);
INSERT INTO Project VALUES (205, 'Project E', 'Phoenix', 5);
INSERT INTO Project VALUES (206, 'Project F', 'San Diego', 6);
INSERT INTO Project VALUES (207, 'Project G', 'Dallas', 7);
INSERT INTO Project VALUES (208, 'Project H', 'Seattle', 8);
INSERT INTO Project VALUES (209, 'Project I', 'Boston', 9);
INSERT INTO Project VALUES (210, 'Project J', 'Austin', 10);

-- Insert Employee_Project data
INSERT INTO Employee_Project VALUES (101, 201, 40);
INSERT INTO Employee_Project VALUES (102, 202, 35);
INSERT INTO Employee_Project VALUES (103, 203, 30);
INSERT INTO Employee_Project VALUES (104, 204, 45);
INSERT INTO Employee_Project VALUES (105, 205, 38);
INSERT INTO Employee_Project VALUES (106, 206, 42);
INSERT INTO Employee_Project VALUES (107, 207, 37);
INSERT INTO Employee_Project VALUES (108, 208, 39);
INSERT INTO Employee_Project VALUES (109, 209, 33);
INSERT INTO Employee_Project VALUES (110, 210, 41);


-- Inserting dependent data for each employee
INSERT INTO dependent VALUES (101, 'John', 'M', 1990, 'Spouse');
INSERT INTO dependent VALUES (102, 'Jane', 'F', 1992, 'Child');
INSERT INTO dependent VALUES (103, 'Alice', 'F', 1993, 'Child');
INSERT INTO dependent VALUES (104, 'Bob', 'M', 1994, 'Spouse');
INSERT INTO dependent VALUES (105, 'Charlie', 'M', 1995, 'Child');
INSERT INTO dependent VALUES (106, 'David', 'M', 1996, 'Child');
INSERT INTO dependent VALUES (107, 'Emma', 'F', 1989, 'Spouse');
INSERT INTO dependent VALUES (108, 'Frank', 'M', 1988, 'Child');
INSERT INTO dependent VALUES (109, 'Grace', 'F', 1987, 'Spouse');
INSERT INTO dependent VALUES (110, 'Henry', 'M', 1986, 'Child');
