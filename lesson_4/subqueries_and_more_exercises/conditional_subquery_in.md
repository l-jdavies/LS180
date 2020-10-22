Write a SQL query that shows all items that have had bids put on them. Use the logical operator IN for this exercise, as well as a subquery.

```
SELECT name AS bid_on_items FROM items
  WHERE id IN
    (SELECT DISTINCT item_id FROM bids);
```
