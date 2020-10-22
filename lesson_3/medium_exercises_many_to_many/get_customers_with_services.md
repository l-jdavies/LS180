Write a query to retrieve the customer data for every customer who currently subscribes to at least one service.


```
SELECT customers.name FROM customers INNER JOIN customers_services
  ON (customers.id = customers_services.customer_id)
GROUP BY customers.name;
```
