
>Object that produces sequential numeric values automatically. In practice, a generator can also be called a "sequence".

- Typical use case: Used to create unique IDs for rows, *especially for primary keys* ([[Claves primarias]]). They enable unique ID generation without manual input. 

### Practical implementation:

1. Create a sequence.

```
CREATE SEQUENCE serial START 101;
```

2. Get the next generated value.

```
SELECT nextval('serial');
```

nextval() is a SQL function used to obtain the next value from a sequence.

3. Use the generator when inserting rows.

```
INSERT INTO distributors VALUES (nextval('serial'), 'nothing');
```

- The professor does it differently though!