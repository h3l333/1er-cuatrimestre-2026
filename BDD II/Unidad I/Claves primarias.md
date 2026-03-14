>Main and "official" identifier of a table. Out of all the *candidate keys* ([[Claves candidatas]]), one is chosen so that the system can associate the table in question with other tables within the database schema. A primary key can be considered a candidate key that has been "promoted".

Restrictions:
- It can NEVER be NULL.
- It can never be repeated, it is unique for each row.
- It must be "static", meaning it cannot change over the course of time.

![[super-candidate-primary.png]]

### Composite primary keys:

>A composite key is a primary key made from two or more columns that together uniquely identify each record in a table. Individually, these columns may not be unique, but their combined values ensure uniqueness. Composite primary keys may be confused with candidate keys ([[Claves candidatas vs. claves primarias compuestas]]).