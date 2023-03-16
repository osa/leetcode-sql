/*
177. Nth Highest Salary

SQL Schema
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
*/


/* Schema */
IF OBJECT_ID(N'dbo.Employee', N'U') IS NULL
Create table Employee (id int, salary int)
Truncate table Employee

insert into Employee (id, salary) values ('1', '100')
insert into Employee (id, salary) values ('2', '200')
insert into Employee (id, salary) values ('3', '300')


/* Solution */

-- rank based on unique salary number
CREATE OR ALTER FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
	DECLARE @salary INT = NULL

	select @salary=salary
	from
	(
		select 
			salary,
			dense_rank() over (order by salary asc) as rnk
		from Employee
	)t
	where rnk = @N


    RETURN @salary;
END



-- rank ignoring uniqueness
CREATE OR ALTER FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
	DECLARE @salary INT = NULL

	select @salary=salary
	from
	(
		select 
			salary,
			row_number() over (order by salary asc) as rnk
		from Employee
	)t
	where rnk = @N


    RETURN @salary;
END
