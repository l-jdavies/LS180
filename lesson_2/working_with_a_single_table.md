1. Write a SQL statement that will create the following table, people:

| name | age | occupation |
| ---- | --- | --- |
| Abby | 34 | biologist |
| Mu'nisah | 26 | NULL |
| Mirabelle | 40 | contractor |

```
CREATE TABLE people (
  name text NOT NULL,
  age integer NOT NULL,
  occupation text
);
```

2. Write SQL statements to insert the data shown in #1 into the table.
```
INSERT INTO people (name, age, occupation)
VALUES  ('Abby', 34, 'biologist'), ('Mu''nisah', 26, NULL), ('Mirabelle', 40, 'contractor');
```

3. Write 3 SQL queries that can be used to retrieve the second row of the table shown in #1 and #2.
```
SELECT * FROM people
WHERE age = 26;

SELECT * FROM people
WHERE occupation IS NULL;

SELECT * FROM people
LIMIT 1 OFFSET 1;
```

4. Write a SQL statement that will create a table named birds that can hold the following values:

| name | length | wingspan | family | extinct |
| --- | --- | --- |--- | --- |
| Spotted Towhee | 21.6 | 26.7 | Emberizidae | f |
| American Robin | 25.5 | 36.0 | Turdidae | f |
| Greater Koa Finch | 19.0 | 24.0 | Fringillidae | t |
| Carolina Parakeet | 33.0 | 55.8 | Psittacidae | t |
| Common Kestrel | 35.5 | 73.5 | Falconidae | f |

```
CREATE TABLE birds (
 name varchar(100),
 length decimal(4,1),
 wingspan decimal(4,1),
 family varchar(100),
 extinct boolean
 NOT NULL
);
```
5. Using the table created in #4, write the SQL statements to insert the data as shown in the listing.

```
INSERT INTO birds (name, length, wingspan, family, extinct)
VALUES ('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
('American Robin', 25.5, 36.0, 'Turdidae', false),
('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true),
('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
('Common Kestrel', 35.5, 73.5, 'Falconidae', false);
```

6. Write a SQL statement that finds the names and families for all birds that are not extinct, in order from longest to shortest (based on the `length` column's value).

```
SELECT name, family FROM birds
WHERE extinct = false
ORDER BY length DESC; 
```

7. Use SQL to determine the average, minimum, and maximum wingspan for the birds shown in the table.
```
SELECT avg(wingspan), min(wingspan), max(wingspan)  FROM birds;
```
Note: should have used `round(avg(wingspan), 1)` to round the result to 1 dp.

8. Write a SQL statement to create the table shown below, menu_items:

| item | prep_time | ingredient_cost | sales | menu_price |
| --- | --- | --- | ---- | --- | 
| omelette | 10 | 1.50 | 182 | 7.99 |
| tacos | 5 | 2.00 | 254 | 8.99 |
| oatmeal | 1 | 0.50 | 79 | 5.99 |

```
CREATE TABLE menu_items (
  item text,
  prep_time integer,
  ingredient_cost decimal(4,2),
  sales integer,
  menu_price decimal(4,2)
);
```

9. Write SQL statements to insert the data shown in #8 into the table.
```
INSERT INTO menu_items (item, prep_time, ingredient_cost, sales, menu_price)
VALUES ('omelette', 10, 1.50, 182, 7.99), ('tacos', 5, 2.00, 254, 8.99),
('oatmeal', 1, 0.50, 79, 5.99);
```

10. Using the table and data from #8 and #9, write a SQL query to determine which menu item is the most profitable based on the cost of its ingredients, returning the name of the item and its profit.

```
SELECT item, menu_price - ingredient_cost AS profit
FROM menu_items
ORDER BY profit DESC;
```

11. Write a SQL query to determine how profitable each item on the menu is based on the amount of time it takes to prepare. Assume that whoever is preparing the food is being paid $13 an hour. List the most profitable items first. Keep in mind that prep_time is represented in minutes and ingredient_cost and menu_price are in dollars and cents):
```
SELECT item, menu_price, ingredient_cost, 
  round(prep_time/60.0 * 13.0, 2) AS labour, 
  round(menu_price - ingredient_cost - prep_time/60.0 * 13.0, 2) AS profit
  FROM menu_items
  ORDER BY profit DESC;
```
