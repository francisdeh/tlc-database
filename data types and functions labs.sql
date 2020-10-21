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
