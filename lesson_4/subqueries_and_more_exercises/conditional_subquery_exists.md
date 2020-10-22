Write a SELECT query that returns a list of names of everyone who has bid in the auction. While it is possible (and perhaps easier) to do this with a JOIN clause, we're going to do things differently: use a subquery with the EXISTS clause instead.

```
SELECT DISTINCT name FROM bidders
  WHERE EXISTS 
    (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

LS discussion:

This is a bit tricky. We know we have to use the EXISTS clause. This clause checks whether the attached subquery returns any rows; if a row is returned, then EXISTS evaluates to true and the current name is grabbed and added to our result table. If we want to include all bidder names, then we need a subquery that will only return rows for anyone who has ever placed a bid. This is why we use SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id.

Only bidders who have never placed a bid would cause this subquery to return 0 rows. If they haven't placed a bid, then their id won't have a matching foreign key in the bids table. As for the initial part of the subquery, SELECT 1, that is arbitrary. We only need a row to be returned to utilize the EXISTS clause; what's in that row doesn't usually matter.
