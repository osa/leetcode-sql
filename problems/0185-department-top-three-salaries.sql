
/*
185. Department Top Three Salaries

SQL Schema
Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key column for this table.
departmentId is a foreign key of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the ID of a department and its name.
*/


/* Schema */

IF OBJECT_ID(N'dbo.Employee', N'U') IS NULL
Create table Employee (id int, name varchar(255), salary int, departmentId int)

IF OBJECT_ID(N'dbo.Department', N'U') IS NULL
Create table Department (id int, name varchar(255))

Truncate table Employee
insert into Employee (id, name, salary, departmentId) values ('1', 'Joe', '85000', '1')
insert into Employee (id, name, salary, departmentId) values ('2', 'Henry', '80000', '2')
insert into Employee (id, name, salary, departmentId) values ('3', 'Sam', '60000', '2')
insert into Employee (id, name, salary, departmentId) values ('4', 'Max', '90000', '1')
insert into Employee (id, name, salary, departmentId) values ('5', 'Janet', '69000', '1')
insert into Employee (id, name, salary, departmentId) values ('6', 'Randy', '85000', '1')
insert into Employee (id, name, salary, departmentId) values ('7', 'Will', '70000', '1')

Truncate table Department
insert into Department (id, name) values ('1', 'IT')
insert into Department (id, name) values ('2', 'Sales')

/* Solution */

-- rank based on unique salary number
;with EmployeeSalaries as (
	select 
		d.name as DepartmentName,
		e.salary as Salary,
		dense_rank() over (partition by d.id order by salary desc) as rnk
	from Department d	join
		Employee e on d.id = e.departmentId
)
select 
	DepartmentName,  
	Salary
from EmployeeSalaries
where rnk <= 3




-- rank ignoring uniqueness
;with EmployeeSalaries as (
	select 
		d.name as DepartmentName,
		e.salary as Salary,
		row_number() over (partition by d.id order by salary desc) as rnk
	from Department d	join
		Employee e on d.id = e.departmentId
)
select 
	DepartmentName,  
	Salary
from EmployeeSalaries
where rnk <= 3