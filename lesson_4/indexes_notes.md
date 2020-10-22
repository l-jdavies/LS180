# Indexes

## What are indexes?

Indexed data is stored in a table-like structure that can be queried using certain search algorithms. The search results return a link to the relation that the indexed data belongs to. Using indexes can increase the speed of queries in SQL; however, indexing data is not always appropriate and can actually result in slower tables if used without consideration. For example, if a table is frequently updated then not only does the table have to be updated but so does the index. Indexes are best suited for columns that map relationships (i.e. foreign key columns) or columns that are frequently specified in an `ORDER BY` clause. There are several different types of indexes that can be used within PostgreSQL, which utilise different data structures and search algorithms. The default index type in PostgreSQL is `btree`.

## Creating indexes

`btree` indexes are automatically created when a `PRIMARY KEY` or `UNIQUE` constraint are defined on a column and are the mechanism by which uniqueness is enforced. `FOREIGN KEY` constraints do not automatically create an index.

### General syntax

```sql
CREATE INDEX index_name ON table_name (column_name);
```

If `index_name` is omitted then PostgreSQL will automatically create a name. All index names must be unique. 

### Unique and non-unique

The indexes created by specifying the `UNIQUE` or `PRIMARY KEY` constraints are unique indexes i.e. multiple rows cannot have the same value in the indexed column. Indexes can also be non-unique, enabled the column to have multiple rows with the same value stored. 

### Multi-column indexes

Multiple columns can be specified when creating an index but only certain index types support multi-column indexes and there's a limit on how many columns can be specified.

```sql
CREATE INDEX index_name ON table_name (column1_name, column2_name);
```

 

### Partial indexes

Indexes can be created on a subset of data by using a conditional expression to define the subset. For example:

```sql
CREATE INDEX services_cost_idx ON services (service_cost)
	WHERE service_cost > 50.0;
```

### Deleting indexes

To view the name of indexes in a table, `\di` . The index name is required when you want to delete an index:

```sql
DROP INDEX services_cost_idx;
```