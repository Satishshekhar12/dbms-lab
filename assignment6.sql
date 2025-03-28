create table employee (
Fname varchar(30) ,
Mname varchar(30) ,
Lname varchar(30) not null,
ssn number primary key,
Bdate Date , 
address varchar(30),
gender char(1),
salary number(10,2), 
super_ssn number ,
dept_num number not null references departments(dept_num) on delete cascade
);

create table departments(
DEPT_NUM number primary key,
dept_name varchar(30) unique not null,
mgr_ssn number ,
mgr_startdate number
);
 

create table department_location( 
dept_num number not null references departments(dept_num) on delete cascade,
location varchar(30) ,
primary key ( dept_num , location) 
);


create table project (
proj_num number primary key,
proj_name varchar(30) ,
proj_location varchar(30) ,
dept_num number not null references departments(dept_num) on delete cascade
);


create table employee_project(
ssn number not null references employee(ssn) on delete cascade,
proj_num number not null references project(proj_num) on delete cascade ,
hours number ,
primary key(ssn , proj_num)
);

create table dependent (
ssn number not null references employee(ssn) on delete cascade,
dept_name varchar(30) not null references departments(dept_name) on delete cascade,
gender char(1),
bdate date,
relationship varchar(30) ,
primary key( ssn ,dept_name) 
);



