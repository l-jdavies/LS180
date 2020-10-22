1. Update the orders table so that referential integrity will be preserved for the data between orders and products.

```
/*One product has many orders so the primary key will be products.id and the foreign key will be orders.product_id*/

ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);
```

2. Use psql to insert the data shown in the following table into the database:
```
 quantity |    name
----------+------------
       10 | small bolt
       25 | small bolt
       15 | large bolt
(3 rows)
```

```
INSERT INTO products (name)
  VALUES ('small bolt'), ('large bolt');

INSERT INTO orders (product_id, quantity)
  VALUES (1, 10), (1, 25), (2, 15);
```

3. Write a SQL statement that returns a result like this:
```
 quantity |    name
----------+------------
       10 | small bolt
       25 | small bolt
       15 | large bolt
(3 rows)
```

```
SELECT orders.quantity, products.name 
  FROM orders INNER JOIN products
    ON (products.id = orders.product_id);
```

4. Can you insert a row into `orders` without a `product_id`? Write a SQL statement to prove your answer.

Yes, you can. Although the `product_id` is a foreign key it doesn't have a `NOT NULL` constraint.
```
INSERT INTO orders (quantity)
VALUES (300);
```

5. Write a SQL statement that will prevent NULL values from being stored in orders.product_id. What happens if you execute that statement?

```
ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;

ERROR: column "product_id" contains null values
```

6. Make any changes needed to avoid the error message encountered in #6.

```
DELETE FROM orders WHERE quantity = 300;
```

7. Create a new table called `reviews` to store the data shown below. This table should include a primary key and a reference to the `products` table.

```
CREATE TABLE reviews (
  id serial PRIMARY KEY,
  review text NOT NULL,
  product_id integer REFERENCES products(id)
);
```

8. Write SQL statements to insert the data shown in the table in #8.

```
INSERT INTO reviews (review, product_id)
VALUES ('a little small', 1), 
  ('very round!', 1), 
  ('could have been smaller', 2);
```

9. True or false: A foreign key constraint prevents NULL values from being stored in a column.

False, this happens with a primary key but not a foreign key.
