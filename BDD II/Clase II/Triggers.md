In DBMS, often generators ([[Generators]]) and triggers are used together to automatically assign unique values, usually for primary keys ([[Claves primarias]]).

>A "trigger" is a code that automically executes when an ***event*** occurs on a table, such as:

- An INSERT
- A DELETE
- An UPDATE

Si se usan antes: 
- Se usan para asegurar que en la tabla se guarden solamente datos validos.

Y si se usan despues:
- Para actualizar datos de otras tablas cuyos datos dependen de esta tabla.

ES SUMAMENTE IMPORTANTE RESPETAR LAS REGLAS DE SEMANTICA. Asegurar la integridad y veracidad de datos. ([[Reglas de integridad]])

Los triggers no pueden ser llamados a ejecucion.
>A trigger cannot be invoked manually like a function or procedure.
>In a DBMS (including Firebird):
>You do not run a trigger directly (no CALL trigger_name or similar).
>A trigger is automatically executed by the system.

## New & Old

>New indica el valor que tiene una columna ANTES de ser insertada en la tabla
>Old indica el valor que tiene ACTUALMENTE la columna en la tabla.

- Son utiles para comparar el valor que queremos introducir con el valor que ya esta guardado en la columna. Ej.: detectamos si el nuevo precio de venta es menor que el actual precio de venta. En tal caso, abortamos la transaccion porque como regla semantica new price no puede ser mas bajo que old price.

```
IF (NEW PRICE < OLD PRICE) THEN
```

En una insercion...

```
IF (NEW PRICE <= 0) THEN
```

Mas ejemplos en las diapositivas!

- **En caso de encontrar un error hay que generar una EXCEPCION. Y asi la fila no se insertara, borrara o actualizara.** ([[Excepciones]])

Como decidimos el orden en que se ejecutan los triggers?
>Manipulando el valor POSITION. Le indica al motor el orden de ejecucion.

**Orden de ejecucion**

- Trigger de before.
- Se aplican y ejecutan todos los CONSTRAINTS. ([[Reglas de integridad]] declarativas)
- Trigger de after.