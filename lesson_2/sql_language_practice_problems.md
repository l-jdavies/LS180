1. What kind of programming language is SQL?
It is a declarative language. This means the commands describe what SQL should do, rather than how to do it. It is also described as a special purpose language because the only function of SQL is to interact with relational databases.

2. What are the three sublanguages of SQL?
* Data Definition Language
* Data Manipulation Language
* Data Control Language

3. Write the following values as quoted string values that could be used in a SQL query.
```
canoe
a long road
weren't
"No way!"
```

```
'canoe'
'a long road'
'weren''t'
'"No way!"'
```
4. What operator is used to concatenate strings?
`||`

5. What function returns a lowercased version of a string? Write a SQL statement using it.
```
lower(string)

SELECT lower('BOB');
```

6. How does the psql console display true and false values?
`t` or `f`

7. The surface area of a sphere is calculated using the formula A = 4π r2, where A is the surface area and r is the radius of the sphere.

Use SQL to compute the surface area of a sphere with a radius of 26.3cm, truncated to return an integer.
```
SELECT trunc(4 * pi() * 26.3 ^ 2);
```


