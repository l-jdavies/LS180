1. Write a SQL statement that makes a new sequence called "counter".

```
CREATE SEQUENCE counter;
```

2. Write a SQL statement to retrieve the next value from the sequence created in #1.

```
SELECT nextval('counter');
```

3. Write a SQL statement that removes a sequence called "counter".

```
DROP SEQUENCE counter;
```

4. Is it possible to create a sequence that returns only even numbers?

Yes, the value the sequence is incremented by can be specified in the `INCREMENT` parameter.
```
CREATE SEQUENCE even_counter INCREMENT BY 2 MINVALUE 2;
```

5. What will the name of the sequence created by the following SQL statement be?
```
CREATE TABLE regions (id serial PRIMARY KEY, name text, area integer);
```

It will be called `regions_id_seq`.

6. Write a SQL statement to add an auto-incrementing integer primary key column to the films table.

```
ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;
```

7. What error do you receive if you attempt to update a row to have a value for id that is used by another row?

```
ERROR: duplicate key value violate unique constraint "films_pkey"
```

8. What error do you receive if you attempt to add another primary key column to the films table?

```
ALTER TABLE films ADD COLUMN another_id serial PRIMARY_KEY;

ERROR: multiple primary keys for table "films" are not allowed
```

9. Write a SQL statement that modifies the table films to remove its primary key while preserving the id column and the values it contains.

```
ALTER TABLE films DROP CONSTRAINT films_pkey;
```
