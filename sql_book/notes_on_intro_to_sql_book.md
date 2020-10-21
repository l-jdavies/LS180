# Introduction to SQL book

## Introduction

### Relational database management systems

A **relational database** defines a set of relations and describes the relationships between them, in order to determine how the data stored in the database can interact. The benefit of this model is that it enables data to be represented in a complex manner and reduces data duplication.

A **relational database management system**, or RDBMS, is a software application for managing relational databases. An RDBMS allows a user or another application, to interact with a database by issuing commands using syntax that conforms to a certain set of conventions. There are many difference RDBMS available that have different pros and cons but they all use the same underlying language - SQL.

### SQL

SQL stands for Structured Query Language and is a declarative language. This means SQL statements describe what needs to be done, not how it is done. The details of how the query is executed is handled by the RDBMS.

Some terms:

- **Relational database:** a structured collection of data that follows the relational model.
- **RDBMS:** relational database management system. An application for managing relational databases.
- **Relation:** set of individual, but related, data entries.
- **SQL:** structured query language; used by RDBMS.
- **SQL statement:** SQL command used to access/ use the database or the data within the database via the SQL language.
- **SQL query:** a sub-set of a SQL statement. A query is used to search data within a database, rather than modifying data.

## Interacting with a database

PostgreSQL is a RDBMS, that can be described as a client-server database. This means a request is sent from a client to a server and the server issues a response. There are many different clients that can be used to issue a request to a server using PostgreSQL and the choice of client will determine the syntax (and level of abstraction) used to issue the request. Regardless of the client used, ultimately PostgreSQL will issue a query to a database using SQL syntax.

### PostgreSQL client applications

PostgreSQL comes packaged with client applications that are used to interact with PostgreSQL by issuing a command via the CLI. Some client applications are wrappers around SQL commands. For example the PostgreSQL application `createdb` is a wrapper around the SQL command `CREATE DATABASE` .

Another client application is `psql` , which is a terminal-based front-end to PostgreSQL. It can be used to write queries in SQL syntax, issue the queries to a PostgreSQL database and view the results in the terminal. 

### Installing PostgreSQL on WSL2

Followed this article: [https://github.com/michaeltreat/Windows-Subsystem-For-Linux-Setup-Guide/blob/master/readmes/installs/PostgreSQL.md](https://github.com/michaeltreat/Windows-Subsystem-For-Linux-Setup-Guide/blob/master/readmes/installs/PostgreSQL.md) and [https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database). 

Followed by:

```bash
sudo -u postgres createuser --superuser $USER
createdb $USER
```

I created aliases in my `.bashrc`:

```bash
alias pg="sudo service postgresql"
alias runpg="sudo -u postgres psql"

# pg start will start a db
# pg stop
```

### `psql` console

The `psql` application can be used for the following:

1. Issuing `psql` console meta-commands
2. Running SQL statements using SQL syntax

Meta-commands are pre-fixed by a backslash followed by the command and any optional arguments. They can be used for a variety of tasks such as connecting to databases, listing tables, listing connection information and more. Meta-commands are not terminate with a semi-colon.

SQL statements always terminate in a semi-colon and they are not case sensitive, although the common convention is for the SQL statement to be in uppercase. For example:

```sql
SELECT name FROM users WHERE id > 4;
```

### SQL sub-languages

SQL is essentially comprised of three individual sub-languages, each of which is utilised for a specific aspect of interacting with a database. The sub-languages are:

- **DDL: Data Definition Language**. This is used to define the structure of a database and its tables and columns.
- **DML: Data Manipulation Language**: Used to retrieve or modify data stored in a database.
- **DCL: Data Control Language**: Used to determine what various users are allowed to do when interacting with a database.

## SQL basics tutorial

### Data vs Schema

**Schema** is concerned with the **structure** of the database. This includes things such as table name, table columns, the data types of the columns and any constraints the columns may have.

**Data** is concerned with the **contents** of a database.

The combination of data and schema enables the database to be interacted with in a complex manner. Without schema, data would be unstructured and without data, schema would just be an empty table.

### Exercises

1. Write a query that returns all of the customer names from the orders table.

```sql
SELECT customer_name FROM orders;
```

2. Write a query that returns all of the orders that include a Chocolate Shake.

```sql
SELECT * FROM orders WHERE drink = 'Chocolate Shake';
```

3. Write a query that returns the burger, side, and drink for the order with an `id` of `2`.

```sql
SELECT burger, side, drink 
FROM orders 
WHERE id = 2;
```

4. Write a query that returns the name of anyone who ordered Onion Rings.

```sql
SELECT customer_name
FROM orders
WHERE side = 'Onion Rings';
```

## Creating and viewing databases

The Data Definition Language is used to create the database as this language handles the schema of a database.

Databases should be named using snake_case and given a descriptive name.

### Create a database

From the terminal issue the command:

```sql
createdb sql_book
```

Using a SQL statement:

```sql
CREATE DATABASE another_database;
```

### Connecting to a database

From the terminal:

```sql
psql -d another_database
```

From `psql` console:

```sql
\connect another_database

/* can use '\c' instead *\
```

### Delete the database

Both `dropdb` and `DROP DATABASE` cannot be reversed and all the data and schema related to the database is deleted.

From the terminal:

```sql
dropdb another_database
```

From `psql` console:

```sql
DROP DATABASE another_database
```

### Exercises

1. From the Terminal, create a database called `database_one`.

```sql
createdb database_one
```

2. From the Terminal, connect via the psql console to the database that you created in the previous question.

```sql
psql -d database_one
```

3. From the psql console, create a database called `database_two`.

```sql
CREATE DATABASE database_two;
```

4. From the psql console, connect to `database_two`.

```sql
\connect database_two
```

5. Display all of the databases that currently exist.

```sql
\list
```

6. From the psql console, delete `database_two`.

```sql
DROP DATABASE database_two;
```

7. From the Terminal, delete the `database_one` and `ls_burger` databases.

```sql
dropdb database_one 
dropdb ls_burger
```

## Create and view tables

Database tables, sometimes referred to as relations, and the relationships between those tables are what really provide the structure we need to house our data. Tables can be used to represent real world abstractions of business logic of an application, such as a customer or an order. Once created, these tables can be used to store our data relevant to that particular abstraction.

### Create table syntax

Tables are created whilst you are connected to a database. To create a table with columns, the column definitions need to be stated between the parentheses. Each column is defined on a separate line, with each line separated by a comma. The syntax for defining a column is `column_name column_data_type constraints` . The `column_name` and `column_data_type` are compulsory and `constraints` are optional.

SQL statement:

```sql
CREATE TABLE some_table (
	column_1_name column_1_data_type [constraints, ...], -- column level constraints
  column_2_name column_2_data_type [constraints, ...],
	constraints -- table level constraints
);
```

Constraints can be defined at the column level or the table level.

### Data Types

A data type determines what type of values can be entered into a column. This can prevent an invalid type of data being entered.

[Common data types:](https://www.notion.so/750b972be1354c6f958d2a8dad0eec03)

### Constraints

Defining constraints is a key part of the database design process that ensures the data within the database is reliable and maintains its integrity.

Some common constraints:

- `UNIQUE`: The `id` column also has a `UNIQUE` constraint, which prevents any duplicate values from being entered into that column.
- `NOT NULL`: The `id` column also has a `NOT NULL` constraint, which essentially means that when adding data to the table a value MUST be specified for this column; it cannot be left empty.
- `DEFAULT`: The `enabled` column has an extra property `DEFAULT` with a value of `TRUE`. If no value is set in this field when a record is created then the value of `TRUE` is set in that field.

### Viewing the table

Display a list of all tables within a database:

```sql
# psql console

\dt

List of relations
 Schema | Name  | Type  |   Owner
--------+-------+-------+-----------
 public | users | table | User
(1 row)
```

Details of a particular table:

```sql
# psql console

\d users

Table "public.users"
  Column  |     Type      |  Modifiers
----------+---------------+----------------------------------------------------
 id       | integer       | not null default nextval('users_id_seq'::regclass)
 username | character(25) |
 enabled  | boolean       | default true
Indexes:
   "users_id_key" UNIQUE CONSTRAINT, btree (id)
```

Note the `\dt` and `\d users` meta-commands only provide details on the schema of the table, not any data.

### Exercises

1. From the Terminal, create a database called `encyclopedia` and connect to it via the `psql` console.

```sql
createdb encyclopedia
psql -d encyclopedia
```

2. Create a table called `countries`. It should have the following columns:

- An `id` column of type `serial`
- A `name` column of type `varchar(50)`
- A `capital` column of type `varchar(50)`
- A `population` column of type `integer`

The `name` column should have a `UNIQUE` constraint. The `name` and `capital` columns should both have `NOT NULL` constraints.

```sql
CREATE TABLE countries (
	id serial,
	name varchar(50) UNIQUE NOT NULL,
	capital varchar(50) NOT NULL,
	population integer
);
```

3. Create a table called `famous_people`. It should have the following columns:

- An `id` column that contains auto-incrementing values
- A `name` column. This should contain a string up to 100 characters in length
- An `occupation` column. This should contain a string up to 150 characters in length
- A `date_of_birth` column that should contain each person's date of birth in a string of up to 50 characters
- A `deceased` column that contains either `true` or `false`

The table should prevent `NULL` values being added to the `name` column. If the value of the `deceased` column is unknown then `false` should be used.

```sql
CREATE TABLE famous_people (
	id serial,
	name varchar(100) NOT NULL,
	occupation varchar(150),
	date_of_birth varchar(50),
	deceased boolean DEFAULT false
);
```

4. Create a table called `animals` that could contain the sample data below:

[Untitled](https://www.notion.so/f6c297b07dff44a8887ae462f258b19f)

- The database table should also contain an auto-incrementing `id` column.
- Each animal should always have a name and a binomial name.
- Names and binomial names vary in length but never exceed 100 characters.
- The max weight column should be able to hold data in the range 0.001kg to 40,000kg
- Conservation Status is denoted by a combination of two letters (CR, EN, VU, etc).

```sql
CREATE TABLE animals (
	id serial,
	name varchar(100) NOT NULL,
	binomial_name varchar(100) NOT NULL,
	max_weight_kg decimal(8,3)
	max_age_years integer,
	conservation_status char(2)
);
```

5. List all of the tables in the `encyclopedia` database.

```sql
\connect encyclopedia
\dt
```

6. Display the schema for the `animals` table.

```sql
\d animals
```

7. Create a database called `ls_burger` and connect to it.

```sql
CREATE DATABASE ls_burger
\connect ls_burger
```

8. Create a table in the `ls_burger` database called `orders`. The table should have the following columns:

- An `id` column, that should contain an auto-incrementing integer value.
- A `customer_name` column, that should contain a string of up to 100 characters
- A `burger` column, that should hold a string of up to 50 characters
- A `side` column, that should hold a string of up to 50 characters
- A `drink` column, that should hold a string of up to 50 characters
- An `order_total` column, that should hold a numeric value in dollars and cents. Assume that all orders will be less than $100.

The `customer_name` and `order_total` columns should always contain a value.

```sql
CREATE TABLE orders (
	id serial,
	customer_name varchar(100) NOT NULL,
	burger varchar(50),
	side varchar(50),
	drink varchar(50),
	order_total decimal(4,2) NOT NULL
);
```

## Alter a table

### Syntax

The basic syntax of an `ALTER TABLE` statement is:

```sql
ALTER TABLE table_to_change HOW TO CHANGE THE TABLE additional arguments
```

### Renaming a table

```sql
ALTER TABLE users
RENAME TO all_users;
```

### Renaming a column

```sql
ALTER TABLE all_users
RENAME COLUMN username TO full_name;
```

### Changing the data type of a column

```sql
ALTER TABLE all_users
ALTER COLUMN full_name TYPE varchar(25);
```

### Adding a constraint

Rather than modifying, constraints need to be added or removed. Each column can have multiple constraints. The syntax for adding constraints can vary depending on the type of constraint we're adding. Some types of constraint are considered 'table constraints' (even if they apply to a specific column) and others, such as `NOT NULL` are considered 'column constraints'.

**Syntax for adding a column constraint:**

```sql
ALTER TABLE table_name ALTER COLUMN column_name SET constraint clause
```

**Syntax for adding a table constraint:**

```sql
ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint clause
```

### Removing a constraint

For most types of constraint, the same syntax can be used for both column and table constraints:

```sql
ALTER TABLE table_name DROP CONSTRAINT constraint_name
```

### Adding a column

```sql
ALTER TABLE all_users
ADD COLUMN last_login timestamp NOT NULL DEFAULT NOW();
```

### Removing a column

```sql
ALTER TABLE all_users DROP COLUMN enabled;
```

### Dropping tables

```sql
DROP TABLE all_users;
```

Actions such as `DROP COLUMN` and `DROP TABLE` are not reversible!!

### Exercises

1. Make sure you are connected to the `encyclopedia` database. Rename the famous_people table to celebrities.

```sql
\connect encyclopedia

ALTER TABLE famous_people RENAME TO celebrities;
```

2. Change the name of the `name` column in the `celebrities` table to `first_name`, and change its data type to `varchar(80)`.

```sql
ALTER TABLE celebrities
RENAME COLUMN name TO first_name;

ALTER TABLE celebrities
ALTER COLUMN first_name 
TYPE varchar(80);

```

3. Create a new column in the celebrities table called `last_name`. It should be able to hold strings of lengths up to 100 characters. This column should always hold a value.

```sql
ALTER TABLE celebrities
ADD COLUMN last_name varchar(100) NOT NULL;
```

4. Change the celebrities table so that the `date_of_birth` column uses a data type that holds an actual date value rather than a string. Also ensure that this column must hold a value.

```sql
ALTER TABLE celebrities
ALTER COLUMN date_of_birth TYPE date,
ALTER COLUMN date_of_birth SET NOT NULL;
```

5. Change the `max_weight_kg` column in the animals table so that it can hold values in the range 0.0001kg to 200,000kg

```sql
ALTER TABLE animals
ALTER COLUMN max_weight TYPE decimal(10,4);
```

6. Change the animals table so that the `binomial_name` column cannot contain duplicate values.

```sql
ALTER TABLE animals
ADD CONSTRAINT unique_binomial_name UNIQUE (binomial_name);
```

## Inserting data into a table

### Data and DML

The Data Manipulation Language can be used to add, query, change and remove data. Data Manipulation Statements can be categorised into four different types:

- `INSERT` statements - add new data into a database table
- `SELECT` statements - also referred to as queries; retrieve existing data from database tables.
- `UPDATE` statements - update existing data in a database table.
- `DELETE` statements - delete existing data from a database table.

### CRUD

The term CRUD is a commonly used acronym in the database world. The letters in CRUD stand for the words CREATE, READ, UPDATE, and DELETE. These four words are analogous to our `INSERT`, `SELECT`, `UPDATE` and `DELETE` statements, and we can think of these statements as performing their equivalent CRUD operations. Web applications whose main purpose is to provide an interface to perform these operations are often referred to as 'CRUD apps'.

### Insert statement syntax

General form of an `INSERT` SQL statement:

```sql
INSERT INTO table_name (column1_name, column2_name...)
VALUES (data_for_column1, data_for_column2...);
```

Three pieces of information are required when using an `INSERT` statement:

1. Name of the table the data should be stored in.
2. Names of the columns the data should be added to.
3. The data that should be stored in the columns.

When inserting data into a table, you may specify all the columns from the table, just a few of them, or none at all. Depending on how your table is structured, and how your data row is ordered, not specifying columns can sometimes lead to unexpected results or errors, so it is generally best to specify which columns you want to insert data into. When specifying columns, for each column specified you *must* supply a value for it in the `VALUES` clause, otherwise you'll get an error back. If you don't specify a column for data insertion, then null or a default value will be added to the record you wish to store instead.

### Adding multiple rows

Multiple rows of data can be added in a single `INSERT` statement:

```sql
INSERT INTO users (full_name)
VALUES ('Jane Smith'), ('Harry Potter');
```

### CHECK constraints

`CHECK` constraints can be used to limit the type of data that can be included in a column, based on a condition that is set in the constraint. Anytime new data is added to a table, the data is validated against the constraint.

For example, if we want to check that a user's name isn't an empty string:

```sql
ALTER TABLE users ADD CHECK (full_name <> '');
```

### Exercises

1. Make sure you are connected to the `encyclopedia` database. Add the following data to the `countries` table:

[Untitled](https://www.notion.so/d979968bf166451a8965e4f4dcdcb8ce)

```sql
\connect encyclopedia

INSERT INTO countries (name, capital, population)
VALUES ('France', 'Paris', 67158000);
```

2. Now add the following additional data to the countries table:

```sql
INSERT INTO countries (name, capital, population)
VALUES ('USA', 'Washington DC', 325365189), ('Germany', 'Berlin', 82349400);
```

3. Add an entry to the `celebrities` table for the singer and songwriter Bruce Springsteen, who was born on September 23rd 1949 and is still alive

```sql
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
VALUES ('Bruce', 'Springsteen', 'Singer, Songwriter', '1949-09-23', false);
```

## Select queries

Querying databases form the Read part of CRUD operations.

### Select query syntax

General form of a `SELECT` SQL statement:

```sql
SELECT [*, (column_name)]
FROM table_name WHERE (condition);
```

The order that the column names are specified in the `SELECT` statement is the order that the columns will be displayed in the response, rather the 'natural' order of the columns in the original table.

Columns that aren't specified in the column list can still be used in the `WHERE` condition.

### Identifiers and keywords

Keywords are terms such as `SELECT`, `WHERE` etc. that issue instructions to PostgreSQL. 

Identifiers identify tables or columns.

It is best practice to avoid using reserved keywords, such as `year` as identifiers. If this is unavoidable then the reserved word should be placed in double quotes so PostgreSQL knows it is an identifier, not a keyword.

## ORDER BY

`ORDER BY` displays the results of a query in a particular sort order. It can be combined with a `WHERE` query:

```sql
SELECT (column_name)
FROM table_name WHERE condition
ORDER BY column_name DESC/ASC;
```

When ordering by boolean values, `false` comes before `true` in ascending order.

You can order by multiple columns. In this situation the data will initially be ordered by the first specified column, any data that has identical values for the first column will then be ordered by the second column.

```sql
SELECT full_name FROM users
ORDER BY id DESC, enabled DESC;
```

As with the `WHERE` clause, you can `ORDER BY` a column that isn't included in the column list.

### Operators

Operators are generally used as part of an expression in a `WHERE` clause. Some operators can be grouped into 3 different types:

1. Comparison
2. Logical
3. String Matching

There are more operators available within PostgreSQL than will be discussed here.

**Comparison operators**

`<` : less than

`>` : greater than

`<>` : not equal to

`=` : equal to

In addition to comparison operators, there are comparison predicates, which function like operators but have a special syntax. We will just look at two of them - `IS NULL` and `NOT NULL` .

`NULL` in SQL means an unknown value. This means the expression `WHERE column_name = NULL` is invalid, instead the comparison predicate `IS NULL` must be used.

**Logical operators**

Logical operators provide flexibility to expressions. The three logical operators are:

- `AND`
- `OR`
- `NOT`

```sql
SELECT * 
FROM users
WHERE full_name = 'Harry Potter' OR 'Sherlock Holmes';
```

**String Matching Operators**

String matching operators search for a sub-set of the data within a column. For example, if you want to search by surname by the data in the `full_name` column contains both the first and surname. This can be performed using the `LIKE` operator:

```sql
SELECT *
FROM users
WHERE full_name LIKE '%Smith';
```

`%` character is a wildcard character.

An alternative to `LIKE` is the `SIMILAR TO` which compares the target column to a Regex pattern.

### Exercises

1. Make sure you are connected to the `encyclopedia` database. Write a query to retrieve the population of the USA.

```sql
SELECT population
FROM countries
WHERE name = 'USA';
```

2. Write a query to return the population and the capital (with the columns in that order) of all the countries in the table.

```sql
SELECT population, capital
FROM countries;
```

3. Write a query to return the names of all the countries ordered alphabetically.

```sql
SELECT name
FROM countries
ORDER BY name DESC;
```

4. Write a query to return the names and the capitals of all the countries in order of population, from lowest to highest.

```sql
SELECT name
FROM countries
ORDER BY population ASC;
```

5. Write a query to return the same information as the previous query, but ordered from highest to lowest.

```sql
SELECT name
FROM countries
ORDER BY population DESC;
```

## More on SELECT

Data can be further filtered by adding `LIMIT`, `OFFSET` and `DISTINCT` clauses to SQL queries.

### LIMIT and OFFSET

Displaying portions of data as separate 'pages' is a user interface pattern used in many web applications, generally referred to as 'pagination'. The `LIMIT` and `OFFSET` clauses of `SELECT` are the base on which pagination is built.

If we only want to view display the results from one user, rather than all users:

```sql
SELECT * FROM users LIMIT 1;
```

If we want to display one row of data but skip the first row:

```sql
SELECT * FROM users LIMIT 1 OFFSET 1;
```

As well as specific use cases such as pagination, `LIMIT` can also be useful in development when testing our queries. We can use `LIMIT` to get a preview or taste of what data is available or would be returned rather than returning the entire dataset. This is especially useful during development when forming your queries and getting an understanding of the dataset and data quality.

### DISTINCT

`DISTINCT` can be used to only return unique values:

```sql
SELECT DISTINCT full_name FROM users;
```

`DISTINCT` can be useful when used in conjunction with SQL functions, such as `count`.

### Functions

Functions are a set of commands included as part of the RDBMS that perform particular operations on fields or data. Some functions provide data transformations that can be applied before returning results. Others simply return information on the operations carried out.

These functions can generally be grouped into different types. Some of the most commonly used types of functions are:

1. String
2. Date/Time
3. Aggregate

**String functions**

```sql
SELECT length(full_name) FROM users;
```

```sql
SELECT trim(leading '' from full_name) FROM users;
```

**Date/ time functions**

```sql
SELECT date_part('year', last_login) FROM users;
```

```sql
/*age function, when passed a single timestamp as an argument 
* will calculate the time elapsed between the timestamp and now *\

SELECT age(last_login) FROM users;
```

**Aggregate function**

These functions return a single result from a set of input values.

```sql
SELECT count(id) FROM users; 
```

```sql
SELECT sum(id) FROM users;
```

```sql
SELECT min(id) FROM users;
```

```sql
SELECT max(id) FROM users;
```

```sql
SELECT avg(id) FROM users;
```

Aggregate functions really start to be useful when grouping table rows together. The way we do that is by using the `GROUP BY` clause.

### GROUP BY

```sql
SELECT enabled, count(id) FROM users GROUP BY enabled;
 enabled | count
---------+-------
 f       |     1
 t       |     4
(2 rows)
```

One thing to be aware of when using aggregate functions, is that if you include columns in the column list alongside the function then those columns must also be included in a `GROUP BY` clause. For example, both of the following statements would return an error:

```sql
SELECT enabled, count(id) FROM users;
SELECT enabled, id, count(id) FROM users GROUP BY enabled;
```

## Update and delete

### Update data in a table

This is achieved with the `UPDATE` and `DELETE` statements.

General syntax of SQL statement:

```sql
UPDATE table_name SET [column_name1 = value1, ...]
WHERE (expression);
```

### Delete data in table

Sometimes simply updating the data in a row isn't enough to fix a particular data discrepancy, and you need to remove that row altogether. This is where the `DELETE` statement comes in.

The `DELETE` statement is used to remove entire rows from a database table.

```sql
DELETE FROM table_name WHERE (expression);
```

 

### Update vs Delete

One key difference to keep in mind between how `UPDATE` works and how `DELETE` works: with `UPDATE` you can update one or more columns within one or more rows by using the `SET` clause; with `DELETE` you can only delete one or more *entire* rows, and not particular pieces of data from within those rows.

Although it's not possible to *delete* specific values within a row, we can approximate this by using `NULL`. You may remember in an earlier chapter we explained that `NULL` is a special value which actually represents an **unknown value**. By using an `UPDATE` statement to `SET` a specific value to `NULL`, although not *deleting* it as such, we are effectively removing that value.

## Table relationships

### Normalisation

Normalisation is the process of placing data in different tables and creating relationships between them. Normalisation removes duplication and improves data integrity.

Normal forms are a complex set of rules that dictate the extent to which a database is judged to be normalised.

### Database design

Database design involves defining entities to represent different data sets and defining the relationship between those entities.

Entities can often be identified as the major nouns of the system that is being modelled. The relationship between the entities can be modelled with a diagram known as an Entity Relationship Diagram (ERD). An ERD is a graphical representation of entities and their relationship to one another.

### Keys

Relationships between entities are implemented through the use of keys. Keys are a special type of constraint used to establish relationships and uniqueness. They can be used to identify a specific row in the current table or refer to a specific row in another table. The two types of keys that fulfil these roles are primary keys and foreign keys.

### Primary keys

A primary key is a unique identifier for a row of data. A column can only be used as a primary key if it contains data and the data is unique to each row. For this reason, the `id` column is commonly used as a primary key. Any column with `UNIQUE` and `NOT NULL` constraints could be used.

Primary keys need to be explicitly defined:

```sql
ALTER TABLE users ADD PRIMARY KEY (id);
```

### Foreign keys

A foreign key allows us to associate a row in one table with a row in another table. This is implemented by setting a column in one table as a foreign key, which references another table's primary key column. This relationship is created using the `REFERENCES` keyword:

```sql
FOREIGN KEY (foreign_col_name) REFERENCES target_table_name (primary_col_name);
```

 Creating this reference ensures referential integrity of a relationship.

The specific way in which a foreign key is used as part of a table's schema depends on the type of relationship that is being modelled between the entities. The different types of entity relationships are:

- One to One
- One to Many
- Many to Many

The same table can have multiple foreign keys, depending on its relationship with other tables.

### One-to-one

A one-to-one relationship between two entities exists when a particular entity instance exists in one table, and it can have only one associated entity instance in another table.

In the database world, this sort of relationship is implemented like this: the `id` that is the `PRIMARY KEY` of the users table is used as both the `FOREIGN KEY` and `PRIMARY KEY` of the addresses table.

```sql
/*
one to one: User has one address
*/

CREATE TABLE addresses (
  user_id int, -- Both a primary and foreign key
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);
```

Executing the above SQL statement will create an `addresses` table, and create a relationship between it and the `users` table. Notice the `PRIMARY KEY` and `FOREIGN KEY` clauses at the end of the `CREATE` statement. These two clauses create the constraints that makes the `user_id` the Primary Key of the `addresses` table and also the Foreign Key for the `users` table.

The `user_id` column uses values that exist in the `id` column of the `users` table in order to connect the tables through the foreign key constraint we just created.

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled.png)

### Referential integrity

Referential integrity is a concept which states that table relationships must always be consistent. In the section above the constraints that have been defined for the `addresses` table enforce the one-to-one relationship with the `users` table: a user can only have one address and an address can have only one user. If you try to enter an address for a user that already has an address or add an address for a user that doesn't exist, PostgreSQL will return an error message.

### ON DELETE clause

When defining a foreign key, the clause `ON DELETE CASCADE` can be added. This means if the row being referenced is deleted then the row referencing it is also deleted. Instead of `CASCADE` alternatives such as `SET NULL` or `SET DEFAULT` could be used, which will set a new value for the referencing row, rather than deleting it.

Determining what to do in situations where you delete a row that is referenced by another row is an important design decision, and is part of the concept of maintaining referential integrity. If we don't set such clauses we leave the decision of what to do up to the RDBMS we are using. In the case of PostgreSQL, if we try to delete a row that is being referenced by a row in another table and we have no `ON DELETE` clause for that reference, then an error will be thrown.

### One-to-many

A one-to-many relationship exists between two entities if an entity instance in one of the tables can be associated with multiple records (entity instances) in the other table. The opposite relationship does not exist; that is, each entity instance in the second table can only be associated with one entity instance in the first table.

**Example:** A review belongs to only one book. A book has many reviews.

```sql
CREATE TABLE books (
  id serial,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

/*
 one to many: Book has many reviews
*/

CREATE TABLE reviews (
  id serial,
  book_id integer NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);
```

The `FOREIGN KEY` column, `book_id` is not bound by the `UNIQUE` constraint of our `PRIMARY KEY` and so the same value from the `id` column of the `books` table can appear in this column more than once. In other words a book can have many reviews.

Data needs to be added into the `books` table before data is added to the `reviews` table. This is because a column in `reviews` references data in `books` and so data needs to be in `books` for it to be referenced.

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%201.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%201.png)

### Many-to-many

A many-to-many relationship exists between two entities if for one entity instance there may be multiple records in the other table, and vice versa.

**Example:** A user can check out many books. A book can be checked out by many users (over time).

In order to implement this relationship a cross-reference table is required. This table has two foreign keys, each of which references the primary key of one of the tables for which we want to create this relationship.

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%202.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%202.png)

Here, the `user_id` column in `checkouts` references the `id` column in `users`, and the `book_id` column in `checkouts` references the `id` column in `books`. Each row of the `checkouts` table uses these two Foreign Keys to create an association between rows of users and books.

```sql
CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);
```

You may have noticed that our table contains a couple of other columns `checkout_date` and `return_date`. While these aren't necessary to create the relationship between the `users` and `books` table, they can provide additional context to that relationship. Attributes like a checkout date or return date don't pertain specifically to users or specifically to books, but to the *association* between a user and a book.

This kind of additional context can be useful within the business logic of the application using our database. For example, in order to prevent more than one user trying to check out the same book at the same time, the app could determine which books are currently checked out by querying those that have a value in the `checkout_date` column of the `checkouts` table but where the `return_date` is set to `NULL`.

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%203.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%203.png)

## SQL joins

A SQL `JOIN` is how queries across multiple tables are handled. `JOIN` clauses link two tables together in a manner that is usually determined by the keys that define the relationship between the two tables. Different JOINs exist, each returning a different result.

### JOIN syntax

**General syntax**

```sql
SELECT [table_name.column_name1, table_name.column_name2,..] FROM table_name1
join_type JOIN table_name2 ON (join_condition);
```

For the second part of the statement, `table_name1 join_type JOIN table_name2 ON (join_condition)` PostgreSQL needs the following information:

- The name of the first table to join
- The type of join to use
- The name of the second table to join
- The join condition.

A join condition defines the logic by which a row in one table is joined to a row in another table. Generally, a join condition is created using the primary key of one table and the foreign key of the second table.

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%204.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%204.png)

These two tables could be joined using the following statement:

```sql
SELECT colors.color, shape.shapes 
FROM colors 
JOIN shapes ON color.id = shapes.color_id;
```

Within the second part of this query, `colors JOIN shapes ON [colors.id](http://colors.id/) = shapes.color_id`, the join condition will look at each `id` value in the `colors` table and attempt to match it with a `color_id` value in the `shapes` table. If there is a match then those two rows are joined together to form a new row in a virtual table known as a join table. Since the `id` `1` for the color `Red` appears twice in the `color_id` column of our `shapes` table, this row of the `colors` table appears twice in our virtual join table, joined to both `Square` and `Star`. Since the `id` `3` for the color `Orange` does not appear at all in the `color_id` column of our `shapes` table, this row of the `colors` table is omitted completely from our virtual join table.

The join table will look like this:

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%205.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%205.png)

From this virtual join table the `SELECT colors.color, shape.shapes 
FROM` part of the statement can be executed and the returned data would look like this:

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%206.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%206.png)

`JOIN`s work by comparing a value from the first table with a value from the second table. If the join condition evaluates to true, when comparing the two values, then the two rows are joined. The values used in the comparison are usually a primary key and a foreign key.

### `INNER JOIN`

An `INNER JOIN` creates an intersection between the two tables and returns a results table that contains rows in which there is a match between the values stored in the columns specified in the join condition.

An `INNER JOIN` is the most commonly used type of join and is the type of join that is performed if a join type isn't specified in a PostgreSQL statement. 

### `LEFT JOIN`

`LEFT OUTER JOIN` also known as a `LEFT JOIN` takes all the rows in the table specified at the left of the `LEFT JOIN` query and joins them with table specified on the right of the join query. The `JOIN` is performed using the join condition specified and the returned result will contain all of the rows from the `LEFT` table, even if there aren't any matching rows in the right table.

### `RIGHT JOIN`

A `RIGHT OUTER JOIN` works with the same principle as the `LEFT JOIN` but the tables are reversed, in other words all of the rows from the table specified to the right of the join query are included in the returned result.

```sql
 SELECT reviews.book_id, reviews.content,
       reviews.rating, reviews.published_date,
       books.id, books.title, books.author
FROM reviews RIGHT JOIN books ON (reviews.book_id = books.id);
```

![Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%207.png](Introduction%20to%20SQL%20book%2049f1dedcb6b94da293fee621d683a7c0/Untitled%207.png)

`FULL JOIN`

A `FULL JOIN` also referred to as a `FULL OUTER JOIN` will return a result that contains all the rows from both tables. For rows in which the join condition is met, the two tables are joined. Rows in which the join condition is not met will have `NULL` values in the rows of the other table.

`CROSS JOIN`

Returns all possible combination of rows from the two joined tables. As all row combinations are returned a `ON` clause isn't required.

```sql
sql_book=# SELECT * FROM users CROSS JOIN addresses;
```

### Multiple joins

Multiple tables can be joined in a `SELECT` statement by adding multiple `JOIN` clauses, providing there is a logical relationship between the multiple tables.

```sql
SELECT users.full_name, books.title, checkouts.checkout_date
FROM users
INNER JOIN checkouts ON (users.id = checkouts.user_id)
INNER JOIN books ON (books.id = checkouts.book_id);
```

An `INNER JOIN` is performed between `users` and `checkouts` using the primary key from `users` and a foreign key from `checkouts` . Then an `INNER JOIN` is performed between `checkouts` and `books` using the primary key from `books` and a different foreign key from `checkouts` .

## Aliasing

Aliasing is when a different name is specified for a table (usually the first letter of the table) or column and the new name is referenced in other parts of the query, to form a more concise syntax. For example:

```sql
SELECT u.full_name, b.title, c.checkout_date
FROM users AS u
INNER JOIN checkouts AS c ON (u.id = c.user_id)
INNER JOIN books AS b ON (b.id = c.book_id);
```

We can even use a shorthand for aliasing by leaving out the `AS` keyword entirely. `FROM users u` and `FROM users AS u` are equivalent SQL clauses.

## Subqueries

Subqueries can be used as an alternative to using `JOIN`s when working with multiple tables. A subquery is when the results from one query are used as a condition in a second query. This is called nesting and the nested query is referred to as a subquery.

```sql
sql_book=# SELECT u.full_name FROM users u
sql_book-# WHERE u.id NOT IN (SELECT c.user_id FROM checkouts c);
  full_name
-------------
 Harry Potter
(1 row)
```

The returned result from the subquery `SELECT c.user_id FROM checkouts c` is used as part of the `WHERE u.id NOT IN` condition of the initial `SELECT` query.

PostgreSQL provides a number of expressions that can be used specifically with sub-queries, such as `IN`, `NOT` `IN`, `ANY`, `SOME`, and `ALL`. These all work slightly differently, but essentially they all compare values to the results of a subquery.

### Subqueries vs joins

You can usually get the same result from using either a subquery or a `JOIN` but `JOIN`s are usually faster.