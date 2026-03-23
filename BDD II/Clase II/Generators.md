>Object that produces sequential numeric values automatically. In practice, a generator can also be called a "sequence".

- Typical use case: Used to create unique IDs for rows, *especially for primary keys* ([[Claves primarias]]). They enable unique ID generation without manual input. 

### Practical implementation:

Assuming Firebird is in use:

1. Create a generator.

```
CREATE GENERATOR serial;
```

2. Get the next generated value.

```
SELECT GEN_ID(serial, 1) FROM RDB$DATABASE;
```

```GEN_ID(generator, step)``` returns the next value of the generator.
The '1' means the generator increments by 1.

3. Use the generator when inserting rows.

```
INSERT INTO distributors VALUES (GEN_ID(serial, 1), 'nothing');
```