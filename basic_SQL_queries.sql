------------------------------------------------------------------------
--------------------Basic SQL queries-----------------------------------
------------------------------------------------------------------------

-- select all columns
select * 
	from customer.customer

-- select all columns, limit to first 100 results	
select * 
	from customer.customer
	LIMIT 100

-- select only person_id column
select person_id 
	from customer.customer
	LIMIT 100
	
-- select only person_id and age
select person_id, age
	from customer.customer
	LIMIT 100

-- select a new column that is a function of an old column
select 	person_id,
		age,
		log(x1) as log_x1
	from customer.customer
	LIMIT 100

-- select a new column that is a function of an old column
select 	person_id,
		age,
		x1/2 as half_x1
	from customer.customer
	LIMIT 100

-- filter rows on the way in 
select person_id, age
	from customer.customer
	where age > 100
	LIMIT 100

-- filter with two variables
select person_id, age, ses
	from customer.customer
	where age > 100 AND ses = 'Low'
	LIMIT 100

-- filter with two variables
select person_id, age, ses
	from customer.customer
	where age > 100 OR ses = 'Low'
	LIMIT 100

-- sort results using order by
select person_id, age
	from customer.customer
	where age > 100
	order by age
	LIMIT 100

-- save a new table from any select statement
create table customer.customer_bad_ages as 
	select person_id, age
		from customer.customer
		where age > 120

-- save a new TEMPORARY table from any select statement
-- This will be deleted when the session ends 
create temporary table customer_bad_ages2 as 
	select person_id, age
		from customer.customer
		where age > 120
-- You can access through SQL statements, but not the GUI
select * from customer_bad_ages2 limit 100

-- count number of rows meeting a condition
select count(*) as n_rows,
	max(age) as max_age,
	min(age) as min_age
	from customer.customer
	where age > 120

-- count missing
select count(*)
	from customer.customer
	where age is NULL

-- identify distinct (unique) values
select distinct 
		gender,
		ses
	from customer.customer

-- variable casting using dates
select to_char(baseline_date, 'day') as bd_day
	from customer.customer
select to_char(baseline_date, 'YYYY') as bd_day
	from customer.customer
-- check docs for more https://www.postgresql.org/docs/11/functions-formatting.html

---- Group by
select max(Age) as max_Age
	from customer.customer
	group by gender

-- need to incldue gender
select max(Age) as max_Age, gender
	from customer.customer
	group by gender

-- can include more than one variable
select max(Age) as max_Age, gender, ses
	from customer.customer
	group by gender, ses


-- filter based on calculated value - requires a sub query
select person_id
	from customer.customer
	where age=max(age) -- doesn't work!
-- use a sub-query
select person_id, age
	from customer.customer
	where age = (select max(age) from customer.customer) -- need a sub-query

---- Joins
-- inner join
select 	person_id, 
		age,
		customer.site_id,
		size
 from customer.customer INNER JOIN 
 		customer.cluster
 		on (customer.site_id = cluster.site_id)

-- left join
select 	person_id, 
		age,
		customer.site_id,
		size
 from customer.customer LEFT OUTER JOIN customer.cluster
 	on (customer.site_id = cluster.site_id)

-- right join
select 	person_id, 
		age,
		customer.site_id,
		size
 from customer.customer RIGHT OUTER JOIN customer.cluster
 	on (customer.site_id = cluster.site_id)

-- outer join	
select 	person_id, 
		age,
		customer.site_id,
		size
 from customer.customer FULL OUTER JOIN customer.cluster
 	on (customer.site_id = cluster.site_id)

-- export query results to a CSV
COPY (SELECT person_id, age 
	  	from customer.customer 
	  	where age > 150)
TO 'c:/temp/test1.csv' with (format CSV, header)
-- need to create temp folder in windows folder