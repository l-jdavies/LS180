For this exercise, we'll make a slight departure from how we've been using subqueries. We have so far used subqueries to filter our results using a WHERE clause. In this exercise, we will build that filtering into the table that we will query. Write an SQL query that finds the largest number of bids from an individual bidder.

For this exercise, you must use a subquery to generate a result table (or virtual table), and then query that table for the largest number of bids.

```
SELECT max(bid_counts.count) FROM
  (SELECT count(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```
