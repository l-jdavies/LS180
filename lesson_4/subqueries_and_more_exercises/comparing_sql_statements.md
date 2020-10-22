In this exercise, we'll use EXPLAIN ANALYZE to compare the efficiency of two SQL statements. These two statements are actually from the "Query From a Virtual Table" exercise in this set. In that exercise, we stated that our subquery-based solution:
```
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;
```

was actually faster than the simpler equivalent without subqueries:
```
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;
```

In this exercise, we will demonstrate this fact.

Run EXPLAIN ANALYZE on the two statements above. Compare the planning time, execution time, and the total time required to run these two statements. Also compare the total "costs". Which statement is more efficient and why?


```
EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;


EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;
```

The planning time of the first statement was `0.309 ms` and the execution time was `0.286 ms`. The total cost of the first statement was `37.16`. The second statement was faster as the planning time was `0.209 ms` and the execution time was `0.163 ms`. The total cost of the second statement was `35.65`. This means the query that used `ORDER BY` and `LIMIT` was faster than using a subquery.


