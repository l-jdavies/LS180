# Using keys

Keys uniquely identify a single row in a database table. Two types of keys are natural keys are surrogate keys.

Natural keys are values that already exist in a database that can be used to uniquely identify each row of data within a dataset. The limitation of using natural keys is that a lot of values stored in a databases are subject to change. A more robust alternative is to use a surrogate key.

A surrogate key is a value that is intentionally created to identify individual rows of data within a dataset. Because the value has no other purpose it is not subject to change and can be easily created to conform to the conventions that govern primary keys (i.e. values are unique and not `null` ).

It is common convention to name the column used as the surrogate key in a table, `id` and assign the column the data type `serial` , which generates an integer that automatically increments. 

The PostgreSQL documentation states that assigning the `serial` data type is equivalent to specifying: 

```sql
CREATE SEQUENCE tablename_colname_seq;

CREATE TABLE tablename (
    colname integer NOT NULL DEFAULT nextval('tablename_colname_seq')
);
```

Initially, a `SEQUENCE` is created, which is a relation that recalls the last integer it created and will increment this integer by the value specified when the `SEQUENCE` was created (default 1) when a new `tablename_colname_seq` value is generated. The value of this sequence is accessed using `nextval` and once an integer has been returned by `nextval` it wont be returned again, regardless of how the integer was utilised. 

The values used as a key also need to be unique otherwise the key cannot be used as a unique identifier. 

An alternative to using the following syntax to create a key column:

```sql
CREATE TABLE example_table (
  id serial UNIQUE, --or id
  colour text
);
```

is to specify a column as a `PRIMARY KEY`:

```sql
CREATE TABLE example_table (
  id int PRIMARY KEY,
  colour name
);
```

This causes PostgreSQL to create an index on the `id` column that can only store unique values and prevents the column from holding `NULL` .

It should be noted that an existing column does not require the `UNIQUE` `NOT NULL` constraints in order to be altered and assigned as a `PRIMARY KEY` but the values in that column do need to be unique and none of the values can be `NULL` . 

The following conventions have been developed for working with tables and primary keys:

- All tables should have a primary key column called `id`.
- The `id` column should be automatically set to a unique value as new rows are inserted into the table.
- Usually, the `id` column values will be integers but other data types (such as UUIDs) can be utilised.

UUIDs = Universally Unique Identifiers