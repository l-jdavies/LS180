Write a query to retrieve the customer data for every customer who does not currently subscribe to any services.

```
SELECT customers.* FROM customers
  LEFT JOIN customers_services
    ON (customers.id = customers_services.customer_id)
WHERE customers_services.service_id IS NULL;
```
