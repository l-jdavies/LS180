Write a query that displays the description for every service that is subscribed to by at least 3 customers. Include the customer count for each description in the report. The report should look like this:
```
 description  | count
--------------+-------
 DNS          |     3
 Unix Hosting |     5
(2 rows)
```

```
SELECT services.description, COUNT(customers_services.service_id)
  FROM services INNER JOIN customers_services
    ON (services.id = customers_services.service_id)
GROUP BY services.description
HAVING COUNT(customers_services.service_id) >= 3;
```
