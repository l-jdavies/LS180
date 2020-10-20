1. Describe the difference between the `varchar` and `text` data types.

`text` is a PostgreSQL data type, not a SQL Standard, whereas `varchar` is a SQL data type. Both store string characters but `varchar` will store a specified number of characters while `text` stores unlimited number of characters.

2. Describe the difference between the `integer`, `decimal`, and `real` data types.

`integer` stores whole numbers, `real` stores floating-point numbers and `decimal` stores arbitrary precision numbers (i.e. have limited precision).

3. What is the largest value that can be stored in an `integer` column?

+2147483647.

4. Describe the difference between the timestamp and date data types.

`timestamp` is the time and date whereas `date` is date only.

5. Can a time with a time zone be stored in a column of type `timestamp`?

No, `timestamp with time zone` is a different data type.

