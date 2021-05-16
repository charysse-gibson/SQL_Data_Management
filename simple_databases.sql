-- create simple table
-- identify each column, then the data type, then any constraints
CREATE TABLE customer.customer2 (
	person_id INT PRIMARY KEY, -- you can declare constraints, PK implies NOT NULL and UNIQUE
	site_id INT,
	age INT,
	gender VARCHAR (10),
	SES VARCHAR (10),
	outcome INT,
	baseline_Date DATE,
	x1 DOUBLE PRECISION,
	funny_Date DATE);

CREATE TABLE customer.cluster (
	site_id INT PRIMARY KEY,
	size VARCHAR(10)
)
-- now use GUI to import both files
