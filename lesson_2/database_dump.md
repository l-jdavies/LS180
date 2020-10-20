1. Load this file into your database.
- What does the file do?
- What is the output of the command? What does each line in this output mean?
- Open up the file and look at its contents. What does the first line do?

```
psql -d database_dump < film_database.sql
```
The file creates a table called `films`.

The output of the command is:
```
NOTICE TABLE "films" does not exist, skipping
DROP TABLE -- the drop table step was skipped
CREATE TABLE -- a table was created
INSERT 0 1
INSERT 0 1
INSERT 0 1 -- three rows were inserted into the table each with one record
```

The first line of the file drops the `films` table if it already exists in the database.

2. Write a SQL statement that returns all rows in the `films` table.

```
SELECT * FROM films;
```

3. Write a SQL statement that returns all rows in the `films` table with a title shorter than 12 letters.

```
SELECT * FROM films
WHERE length(title) < 12;
```

4. Write the SQL statements needed to add two additional columns to the films table: `director`, which will hold a director's full name, and `duration`, which will hold the length of the film in minutes.

```
ALTER TABLE films ADD COLUMN director varchar(100);
ALTER TABLE films ADD COLUMN duration integer;
```

5. Write SQL statements to update the existing rows in the database with values for the new columns:

| title | director | duration |
| --- | --- | --- |
| Die Hard | John McTiernan | 132 |
| Casablanca | Michael Curtiz | 102 |
| The Conversation | Francis Ford Coppola | 113 |

```
UPDATE films SET director = 'John McTiernan', duration = 132
WHERE title = 'Die Hard';

UPDATE films SET director = 'Michael Curtiz', duration = 102
WHERE title = 'Casablanca';

UPDATE films SET director = 'Francis Ford Coppola', duration = 113
WHERE title = 'The Conversation';
```

6. Write SQL statements to insert the following data into the films table:

| title | year | genre | director | duration |
| --- | --- | --- | --- | --- |
| 1984 | 1956 | scifi | Michael Anderson | 90 |
| Tinker Tailor Soldier Spy | 2011 | espionage | Tomas Alfredson | 127 |
| The Birdcage | 1996 | comedy | Mike Nichols | 118 |

```
INSERT INTO films (title, year, genre, director, duration)
VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
  ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
  ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);
```

7. Write a SQL statement that will return the title and age in years of each movie, with newest movies listed first:

```
SELECT title, extract("year" from current_date) - "year" AS age 
  FROM films
  ORDER BY age ASC;
```

8. Write a SQL statement that will return the title and duration of each movie longer than two hours, with the longest movies first.

```
SELECT title, duration FROM films
  WHERE duration > 120
  ORDER BY duration DESC;
```

9. Write a SQL statement that returns the title of the longest film.

```
SELECT title FROM films
  ORDER BY duration DESC
  LIMIT 1;
```
