1. Write the SQL statement needed to create a join table that will allow a film to have multiple directors, and directors to have multiple films. Include an id column in this table, and add foreign key constraints to the other columns.

```
CREATE TABLE films_directors (
  id serial PRIMARY KEY,
  film_id integer NOT NULL REFERENCES films (id),
  director_id integer NOT NULL REFERENCES directors (id)
);
```
Note: should have named the table `directors_films` in alphabetical order.

2. Write the SQL statements needed to insert data into the new join table to represent the existing one-to-many relationships.

```
INSERT INTO films_directors (film_id, director_id)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 3), (8, 7), 
  (9, 8), (10, 4);
```

3. Write a SQL statement to remove any unneeded columns from films.

```
ALTER TABLE films DROP COLUMN director_id;
```

4. Write a SQL statement that will return the following result:
```
           title           |         name
---------------------------+----------------------
 12 Angry Men              | Sidney Lumet
 1984                      | Michael Anderson
 Casablanca                | Michael Curtiz
 Die Hard                  | John McTiernan
 Let the Right One In      | Michael Anderson
 The Birdcage              | Mike Nichols
 The Conversation          | Francis Ford Coppola
 The Godfather             | Francis Ford Coppola
 Tinker Tailor Soldier Spy | Tomas Alfredson
 Wayne's World             | Penelope Spheeris
(10 rows)
```

```
SELECT films.title, directors.name 
  FROM films INNER JOIN films_directors
    ON (films.id = films_directors.film_id)
  INNER JOIN directors
    ON (directors.id = films_directors.director_id)
ORDER BY films.title;
```

5. Write SQL statements to insert data for the following films into the database:

| Film | Year | Genre | Duration | Directors |
| --- | --- | --- | --- | --- |
| Fargo | 1996 | comedy | 98 | Joel Coen |
| No Country for Old Men | 2007 | western | 122 | Joel Coen, Ethan Coen |
| Sin City | 2005 | crime | 124 | Frank Miller, Robert Rodriguez |
| Spy Kids | 2001 | scifi | 88 | Robert Rodriguez |

```
INSERT INTO films (title, year, genre, duration)
VALUES ('Fargo', 1996, 'comedy', 98),
  ('No Country for Old Men', 2007, 'western', 122),
  ('Sin City', 2005, 'crime', 124),
  ('Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors (name)
VALUES ('Joel Coen'), ('Ethan Coen'),
  ('Frank Miller'), ('Robert Rodriguez');

INSERT INTO films_directors (film_id, director_id)
VALUES (11, 9), (12, 9), (12, 10), (13, 11), (13, 12), (14, 12);
```

6. Write a SQL statement that determines how many films each director in the database has directed. Sort the results by number of films (greatest first) and then name (in alphabetical order).

```
SELECT directors.name AS director, COUNT(films_directors.director_id) AS films
  FROM directors INNER JOIN films_directors 
    ON (directors.id = films_directors.director_id)
  GROUP BY directors.name
ORDER BY COUNT(films_directors.director_id) DESC, directors.name;
```
