# Subquery expressions

Subquery expressions are operators that are specifically used with subqueries, usually within a conditional subquery.

## `EXISTS`

Checks if any rows are returned by the nested query. `EXISTS` returns 'true' if at least one row is returned, otherwise it returns 'false'.

```ruby
my_books=# SELECT 1 WHERE EXISTS
my_books-#   (SELECT id FROM books
my_books(#     WHERE isbn = '9780316005388');
 ?column?
----------
        1
(1 row)
```

## `IN`

Compares an evaluated expression to every row in the subquery result. If a row equal to the evaluated expression is found then `IN` returns 'true', otherwise it returns 'false'.

```ruby
my_books=# SELECT name FROM authors WHERE id IN
my_books-#   (SELECT author_id FROM books
my_books(#     WHERE title LIKE 'The%');
      name
----------------
 Iain M. Banks
 Philip K. Dick
(2 rows)
```

"Here, the nested query returns a list of author_id values (2, 3) from the books table where the title of the book for that row starts with 'The'. The outer query then returns the name value from any row of the authors table, where the id for that row is in the results from the nested query."

## `NOT IN`

Same concept as `IN` but 'true' is returned if an equal row is not found. Otherwise 'true' is returned.

```ruby
my_books=# SELECT name FROM authors WHERE id NOT IN
my_books-#   (SELECT author_id FROM books
my_books(#     WHERE title LIKE 'The%');
      name
----------------
 William Gibson
(1 row)
```

"Here, the nested query again returns a list of author_id values (2, 3) from the books table where the title of the book for that row starts with 'The'. The outer query then returns the name value from any row of the authors table, where the id is not in the results from the nested query."

## `ANY/SOME`

Can be used interchangeably and are used with an operator (`=` `<` `>`). 'True' is returned if evaluation of the operator between any of the values returned by the nested query and the expression to the left of the operator returns 'true'.

When `=` is used as the operator with `ANY/SOME` then this is equivalent to `IN`.

```ruby
my_books=# SELECT name FROM authors WHERE length(name) > ANY
my_books-# (SELECT length(title) FROM books
my_books(# WHERE title LIKE 'The%');
      name
----------------
 William Gibson
 Philip K. Dick
(2 rows)
```

"Here, the nested query returns the string length of any book title starting with 'The', (20, 13). The outer query then returns the name of any author where the length of name is greater than any of the results from the nested query. Two of the author names are 14 characters in length and so satisfy the condition since they are greater in length than at least one of the title lengths (13) from the results of the nested query."

## `ALL`

Similar to above but `ALL` returns 'true' only if all the comparisons between the expression and subquery results return 'true'.