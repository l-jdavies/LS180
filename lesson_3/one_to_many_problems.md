1. Write a SQL statement to add the following call data to the database:

| when | duration | first_name | last_name | number |
| --- | --- | --- | --- | --- |
| 2016-01-18 14:47:00 | 632 | William | Swift | 7204890809 |

```
INSERT INTO calls ("when", duration, contact_id)
VALUES ('2016-01-18 14:47:00', 632, 6);
```

2. Write a SQL statement to retrieve the call times, duration, and first name for all calls not made to William Swift.

```
SELECT calls.when, calls.duration, contacts.first_name
  FROM calls INNER JOIN contacts
    ON (calls.contact_id = contacts.id)
WHERE contacts.first_name != 'William' AND contacts.last_name!= 'Swift';
```

3. Write SQL statements to add the following call data to the database:

| when | duration | first_name | last_name | number |
| --- | --- | --- | --- | --- |
| 2016-01-17 11:52:00 | 175 | Merve | Elk | 6343511126 |
| 2016-01-18 21:22:00 | 79 | Sawa | Fyodorov | 6125594874 |

```
INSERT INTO contacts (first_name, last_name, number)
  VALUES ('Merve', 'Elk', 6343511126),
  ('Sawa', 'Fyodorov', 6125594874);

INSERT INTO calls ("when", duration, contact_id)
  VALUES ('2016-01-17 11:52:00', 175, 26),
  ('2016-01-18 21:22:00', 79, 27);
```

4. Add a constraint to `contacts` that prevents a duplicate value being added in the column `number`.

```
ALTER TABLE contacts ADD CONSTRAINT number_unique UNIQUE (number);
```

5. Write a SQL statement that attempts to insert a duplicate number for a new contact but fails. What error is shown?

```
INSERT INTO contacts (first_name, last_name, number)
VALUES ('Jo', 'Blogs', 6343511126);

ERROR: duplicate key violates unique constraint "number_unique"
```

6. Why does "when" need to be quoted in many of the queries in this lesson?

Because `when` is a keyword in PostgreSQL but we are using it as an identifer. Double quoting a string means it will always be interpreted as an identifier. 
