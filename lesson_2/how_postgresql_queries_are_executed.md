# How PostgreSQL executes queries

SQL is a declarative language where the SQL statement describes what to do, not how to do it. The 'how' is determined by the PostgreSQL server, which takes each query, determines how it should be executed, then returns the result.

The benefit of this approach is that it abstracts the complexity away from the user, enabling the user to function at a higher level. The disadvantage is that sometimes the database will execute a query in an inefficient manner.

The exact steps involved in executing a query will depend on many variables but each query goes through the same high-level processes, knowledge of which can be utilised to understand by two queries return the same results or why the database rejects some queries. 

The high-level process for a `SELECT` query can be summarised as:

1. Data from the tables specified in the query's `FROM` clause are collected into a virtual derived table. 
2. Row are filtered using the `WHERE` conditions and any rows that don't meet the requirements are removed from the derived table.
3. If the query includes a `GROUP BY` clause then the rows are divided into the appropriate groups.
4. Groups are filtered based on `HAVING` conditions.
5. Each element specified in the `SELECT` list is evaluated and the resulting values are associated with either the name of the column the values are stored in, the name of the last function evaluated or the name specified in the query following `AS` .
6. If the query has an `ORDER BY` clause then the results are sort accordingly. Otherwise the return order of the results is determined by how the database executed the query and the order of the rows in the original table.
7. If the query contains `LIMIT` or `OFFSET` clauses then they are used to adjust which rows are included in the dataset that is returned.