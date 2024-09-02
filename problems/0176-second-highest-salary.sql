/*
176. Second Highest Salary

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
 

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

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
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
*/



/* Schema */
IF OBJECT_ID(N'dbo.Employee', N'U') IS NULL
Create table Employee (id int, salary int)
Truncate table Employee

insert into Employee (id, salary) values ('1', '100')
insert into Employee (id, salary) values ('2', '200')
insert into Employee (id, salary) values ('3', '300')


/* Solution */


declare @SecondHighestSalary int

-- rank based on unique salary number
;with RankedSalary as (
	select 
		salary,
		dense_rank() over (order by salary asc) as rnk
	from Employee
)
select @SecondHighestSalary=salary 
from RankedSalary
where rnk = 2

select @SecondHighestSalary SecondHighestSalary
