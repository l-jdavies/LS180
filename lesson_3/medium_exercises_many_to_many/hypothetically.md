The company president is looking to increase revenue. As a prelude to his decision making, he asks for two numbers: the amount of expected income from "big ticket" services (those services that cost more than $100) and the maximum income the company could achieve if it managed to convince all of its customers to select all of the company's big ticket items.

For simplicity, your solution should involve two separate SQL queries: one that reports the current expected income level, and one that reports the hypothetical maximum. The outputs should look like this:

```
 sum
--------
 500.00
(1 row)
```

```
   sum
---------
 10493.00
(1 row)
```

```
SELECT sum(services.price) FROM services INNER JOIN customers_services
  ON (services.id = customers_services.service_id)
WHERE price > 100;

SELECT sum(services.price) FROM services 
  CROSS JOIN customers
WHERE services.price > 100.00;
```
