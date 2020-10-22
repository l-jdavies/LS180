For this exercise, use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the name of each item along with the number of bids on an item.

```
SELECT name,
  (SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;
```

LS discussion:

So far, we've seen quite a few ways to use subqueries. They can be used in the WHERE clause, within the FROM clause, and now we see they may be used within the expression list that comes right after SELECT. A good way to understand this is to break it up. First, let's analyze the subquery.
```
SELECT COUNT(item_id) FROM bids WHERE item_id = items.id;
```

This counts the number of bids on a particular item where the item_id is equal to the current items.id. For each item in the outer SELECT, items.id will equal the current id value from that outer SELECT. This kind of subquery lets us conveniently query another table and then associate that table's data with another table based on a foreign key.
