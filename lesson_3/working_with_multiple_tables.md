1. Write a query that determines how many tickets have been sold.

```
SELECT count(customer_id) FROM tickets;
```

2. Write a query that determines how many different customers purchased tickets to at least one event.

```
SELECT COUNT(DISTINCT customer_id) FROM tickets;
```

3. Write a query that determines what percentage of the customers in the database have purchased a ticket to one or more of the events.

```
SELECT COUNT(DISTINCT tickets.customer_id) / COUNT(DISTINCT customers.id)::float * 100 AS percentage
FROM customers LEFT JOIN tickets
ON (customers.id = tickets.customer_id);
```

4. Write a query that returns the name of each event and how many tickets were sold for it, in order from most popular to least popular.

```
SELECT events.name, COUNT(tickets.event_id) AS popularity
FROM tickets LEFT JOIN events
ON (events.id = tickets.event_id)
GROUP BY events.name
ORDER BY COUNT(tickets.event_id) DESC;
```
Note should have used `FROM events LEFT JOIN tickets` to ensure all the events were returned. Wasn't an issue here because all the events had tickets sold.

5. Write a query that returns the user id, email address, and number of events for all customers that have purchased tickets to three events.

```
SELECT c.id, c.email, COUNT(DISTINCT t.event_id)
FROM customers c INNER JOIN tickets t
ON (c.id = t.customer_id)
GROUP BY c.id
HAVING COUNT(DISTINCT t.event_id) = 3;
```

6. Write a query to print out a report of all tickets purchased by the customer with the email address 'gennaro.rath@mcdermott.co'. The report should include the event name and starts_at and the seat's section name, row, and seat number.

```
SELECT e.name AS event, e.starts_at, sec.name AS section, seats.row, seats.number AS seat
  FROM customers INNER JOIN tickets
    ON (customers.id = tickets.customer_id)
  INNER JOIN events e
    ON (e.id = tickets.event_id)
  INNER JOIN seats
    ON (seats.id = tickets.seat_id)
  INNER JOIN sections sec
    ON (sec.id = seats.section_id)
WHERE customers.email = 'gennaro.rath@mcdermott.co';
```
