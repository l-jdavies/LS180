Assuming nothing about the existing order of the records in the database, write an SQL statement that will return the name of the oldest device from our devices table.

```
SELECT name FROM devices
ORDER BY created_at ASC
LIMIT 1;
```
