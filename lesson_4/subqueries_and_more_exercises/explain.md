For this exercise, let's explore the EXPLAIN PostgreSQL statement. It's a very useful SQL statement that lets us analyze the efficiency of our SQL statements. More specifically, use EXPLAIN to check the efficiency of the query statement we used in the exercise on EXISTS:

```
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

First use just EXPLAIN, then include the ANALYZE option as well. For your answer, list any SQL statements you used, along with the output you get back, and your thoughts on what is happening in both cases.

```
EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

The SQL statement `EXPLAIN` was used to return the query plan for the `SELECT` statement. The overall cost of the `SELECT` statement is estimated to be `66.47`. This is detailed in the `Hash Join (cost=33.38..66.47)` part of the query plan. The startup cost is estimated to be `33.38`.


```
EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);
```

Including the `ANALYZE` statement in addition to `EXPLAIN` results in the query being executed and a query plan that details the actual executation time is included. The `SELECT` statement took `0.194 ms` to execute.

LS discussion:

EXPLAIN is used to show statistics about the query plan for a SQL statement. Here is the general form for EXPLAINs syntax:

EXPLAIN sql_expression;

Let's go through the output of each EXPLAIN statement and see what is going on.

The first EXPLAIN statement contains a fair amount of information. Each row represents an operation taken. The following items are listed in each row of information.

The name of the node used to perform the SQL statement. A node represents some operation taken to run the SQL statement. An example would be the name in the first row of our query plan, Hash Join
The estimated startup cost and estimated total cost. These can be seen here: Hash Join (cost=33.38..62.84 rows=635 width=32) The first number after cost is the estimated startup cost, and the second is the estimated total cost.
The estimated number of rows to be shown when the SQL statement we are explaining is run. This is the number right after rows= above.
The width is the estimated amount in bytes taken up by rows for the SQL statement we are explaining.
Did you notice how some nodes are nested further in than others? A nested node represents one that is a child of the one above it. That means that nested nodes were operations necessary to allow the parent node(operation) to run its course. One other important fact is that all of these numbers represent estimates. The SQL statement we're explaining isn't actually run, so all information listed above is an approximation of what will actually happen. Another thing to consider are the units used for describing the estimated startup and total costs. These units are arbitrary and are used by PostgreSQL internally to create the query plan. Their main purpose is to give some measure of the efficiency of using certain nodes, taking certain operations to execute a SQL statement. If the cost is greater than some other group of operations then it will probably be dropped for an alternative approach.

Next, let's take a look at the information that was added when we used the ANALYZE option. The information here is mostly the same: cost, rows, and width are still there. But there is one other bit of information that has been added to each node: the actual_time required for the startup and execution of that node. At the end of our query plan, the planning and execution time have also been added: these represent the total time required to set up the SQL statement along with the total time it took to execute that SQL statement.

Since the SQL statement is actually run when we use EXPLAIN ANALYZE, the results we get from our query plan are the actual results, and not estimates; that includes the costs and the measures of time elapsed per operation.

Now, one might wonder why bother with the EXPLAIN statement at all? Well, this statement can actually be really useful. We can compare the costs of running different SQL statements, which can help us with optimizing our DB calls. There may be some SQL statements that we don't actually want to run, but just want some estimated data on: in that case, use EXPLAIN. But, if we're ok with running the statement, and we need some extra data(maybe to compare the elapsed execution and setup time between two equivalent SQL statements), then we should use EXPLAIN ANALYZE.

We've been talking about runtimes and optimizing for efficiency between SQL statements. And now that you're a bit better equipped to understand how EXPLAIN works, you can try using it. The next exercise will focus on doing just that.
