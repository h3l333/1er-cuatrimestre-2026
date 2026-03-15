The UNIQUE constraint ensures that all values in a column are different.

Both the UNIQUE and PRIMARY KEY constraints provide a guarantee for uniqueness for a column or set of columns.

A PRIMARY KEY constraint automatically has a UNIQUE constraint.

However, you can have many UNIQUE constraints per table, but only one PRIMARY KEY constraint per table.

>Credit: https://www.w3schools.com/mysql/mysql_unique.asp

Example:

- Rule: A student cannot sign up *twice* to the same course.
- Implementation:

```
ALTER TABLE INSCRIPCIONES
ADD CONSTRAINT uq_alumno_curso
UNIQUE (id_alumno, id_curso);
```

Note: we can add constraints when we create tables too, not just after the fact.