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