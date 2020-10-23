-- find all titles
select * from titles;

-- titles with an undefined price
select title, price from titles where price is null;

-- find titles with undefined price and supply price of $20.00 for those with no defined price
select title, '$20.00' as price from titles where price is null;
select title, '20'::money as price from titles where price isnull;


-- first 50 characters of the pr_info column of the pub_info table
select substr(pr_info, 1, 50) from pub_info;
select substr(pr_info, 1, 50) || '...' from pub_info;

select substr(title, 1, 50) || '...' as title from titles;


-- convert date values to varchar
select to_char(current_timestamp, 'HH:MI:SS');
select current_timestamp::varchar;


-- format dates
select stor_id, ord_date, to_char(ord_date, 'Day DDth Month YYYY') as formatted_date from sales;

-- Functions
-- current date
select current_date;
-- current time
select current_time;
-- current timestamp
select current_timestamp;

-- convert string to date
select '2018-09-26'::date;
select to_date('2018-09-26', 'YYYY MM DD');

-- convert string to timestamp
select '2018-09-26'::timestamp;

-- subtracting dates
select  '2018-12-25'::date  - '2018-09-26'::date;
select to_date('20181225', 'YYYYMMDD') - to_date('20180926', 'YYYYMMDD') || ' days';

-- elapsed dates
select title, pubdate, current_date, current_date - pubdate::date as days from titles;
-- extract dates
select pubdate, extract(year from pubdate)::varchar as year from titles;
select pubdate, to_char(pubdate, 'YYYY') as year from titles;

select pubdate, to_char(pubdate, 'Day') as day from titles;

-- Using TIMESTAMPDIFF(), get the difference between these dates: '2018-03-02' and '2018-02-01'.
select '2018-03-02'::date - '2018-02-01'::date as day;
SELECT abs(extract(epoch from '2018-03-02'::timestamp - '2018-02-01'::timestamp)/3600)::int as hour;
SELECT abs(extract(epoch from '2018-03-02'::timestamp - '2018-02-01'::timestamp)/(3600 * 24))::int as day;

-- In a SELECT-statement, add the difference between 2011-01-01 and the current date to the sales date field in the sales table.
-- The output should show both the new value and original sales date, with the original in dd-mm-yy format.
select ord_date, ord_date::date +(current_date - '2011-01-01'::date) as sales_date from sales;
select ord_date as "original date", (current_timestamp - '2011-01-01'::timestamp) + ord_date as "new date" from sales;

-- today and christmas day
select abs(current_date - '2020-12-25'::date);
-- date of birth difference
select abs(extract(year from current_date) - 1992);

-- GROUPING AND AGGREGATE FUNCTIONS
-- get average prices
select type::char(30), avg(price::numeric)  from titles group by type;
select type::char(30), avg(coalesce(price::numeric, 0))  from titles group by type;

-- difference between the earliest and latest publication dates in titles
select min(pubdate) as mindate, max(pubdate) as maxdate, max(pubdate::date) - min(pubdate::date) as days from titles;
select  max(pubdate::date) - min(pubdate::date) as days from titles;

select max(title) from titles;

-- Workshop Labs
--List all data from the departments table.
select * from departments;

-- List all data from the employees table
select * from employees;

-- Write a query to display the last name, job id, hire date and employee ID for each employee with the employee ID column listed first. Provide an alias of start date for the hire date column.
select employee_id, last_name, job_id, hire_date as start_date from employees;

-- List all the unique job IDS from the employees table.
select distinct job_id from  EMPLOYEES order by job_id;

-- Write a query to list all employees and job IDs in a single column output with a comma and a space between the last name and the job id. The output should look like this:
select last_name ||  ', ' || job_id from employees;

-- Write a query to list employees last name, department ID and salary for employees with a salary between 3000 and 4000.
select last_name, department_id, salary from employees where salary between 3000 and 4000;

-- Write a query to display the first name, the last name, the hire date and the salary for employees with a name of Tobias end Jones. Sort the output by salary.
select salary, first_name, last_name, department_id, hire_date from employees where first_name in ('Tobias', 'Jones') or last_name in ('Tobias', 'Jones') order by salary;

-- Display the last name and department ID of employees in departments 30 or 80 in ascending alphabetical order by name.
select last_name, department_id from employees where department_id IN (30, 80) order by last_name;

-- List all employees with a hire date in 2005.
select  department_id,last_name,hire_date from employees where extract(year from hire_date) = 2005 order by last_name;

-- Write a query to list employees who have no manager.
select * from employees where manager_id is null;

-- Write a query to show show the last name, salary and commission of all employees who earn a commission. Sort the data in ascending order of salary.
select * from employees where commission_pct is not null order by salary;

-- Write a query to list all employees where the third character is a g.
select first_name, last_name from employees where first_name like '__g%' or last_name like '__g%';

-- Write a query to list all employees that have both a ‘g’ and a ‘k’ in their last name.
-- select first_name,last_name from employees where REGEXP_LIKE(last_name ,'(.*[Gg].*[kK])|(.*[Kk].*[gG])'); -- ORACLE
select regexp_matches(last_name ,'(.*[Gg].*[kK])|(.*[Kk].*[gG])') from employees;
select first_name,last_name from employees where last_name like any (values('%k%'), ('%K'), ('%g%'), ('%G'));

-- List all employees that have a commission of 20%
select * from employees where commission_pct = 0.2;

-- Write a query to list all employees their last name their salary and include a new salary column which is their original salary plus a 30% increase
select last_name, salary, salary + (0.3 * salary) as new_salary from employees;
select last_name, salary, salary * 1.3 as "new salary" from employees;

-- Write a query that lists the employees last name and the length of the last name.
select last_name, length(last_name) as name_length from employees;

-- Write a query that lists employee last name and calculate how many weeks they have worked for the company. Hint: (sysdate-hire_date)
select last_name, (current_date - hire_date) /7  as weeks from employees; -- 9635/7
select last_name, CAST((current_date - hire_date) /7 AS INTEGER)  as weeks from employees; -- ORACLE

-- Write a query that Returns employee last name in uppercase and employ first name in lowercase
select upper(last_name), lower(first_name) from employees;

-- Write a query that lists the highest salary, The sum of all salaries, the average salary and the minimum salary of all employees
select max(salary), sum(salary), min(salary), avg(salary) from employees;
select max(salary), sum(salary), min(salary), cast(avg(salary) as int) from employees;

-- 20. Write a query to display the number of people working in each department
select department_id, count(department_id) from employees group by department_id;
-- select count(last_name) from employees where department_id = 20;