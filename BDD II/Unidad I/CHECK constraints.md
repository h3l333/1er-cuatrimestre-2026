- https://www.w3schools.com/mysql/mysql_check.asp

Ejemplos de reglas y check:

1. 
	- Regla: La edad de una persona debe ser mayor que 0 y menor o igual a 120.
	- Ejemplo de restricción:
		```CHECK (edad > 0 AND edad <= 120)```

2. 
	- Regla: La fecha de finalización de un proyecto debe ser *posterior* a la fecha de inicio.
	- Ejemplo de restricción:
		```CHECK (fecha_fin > fecha_inicio)```

---

To add CHECK constraints to an existing table, we can use the ALTER TABLE statement (https://www.w3schools.com/sql/sql_alter.asp) as follows:

- Suppose the table PRODUCTO(ID, PRECIO, STOCK)

```
ALTER TABLE PRODUCTO
ADD CONSTRAINT chk_precio
CHECK (PRECIO > 0);
```

How about *other constraints*? ([[UNIQUE constraint]])