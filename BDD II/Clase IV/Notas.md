Es recomendable tener las tablas de BDD en un mismo nodo de la red para mantener la integridad de datos ([[Reglas de integridad]]), optimizar el rendimiento y simplificar la administración. La excepción es en los caso de microservicios (en dónde importa la escalabilidad).

Los execute statements son convenientes para actualizar los datos en una tabla en una BDD de una maquina distinta al host local. Los execute statements se "envian" como strings para ser ejecutados por el motor de BDD local de la maquina en cuestion.
Las transacciones en Firebird son bloques de operaciones SQL que se ejecutan como una única unidad lógica. Sirven para garantizar que los cambios en una BDD sean consistentes, seguros y controlados al prevenir que esta quede en un estado de inconsistencia:

- Si 1 operación o más fallan -> ROLLBACK (se deshace el bloque entero)
- Si todas salen bien -> COMMIT (se deshace todo el bloque)
Las transacciones pueden ser interrumpidas y forman parte de cualquier motor de BDD. 

isc_start_transaction (función de la application programming interface de C que inicia una transacción; ISC viene de 'InterBase Software Corportation', empresa que desarrollo InterBase, RDBMS de la que se derivo Firebird).

---

Puedo saber que estoy dentro de una transacción ejecutando: 

`SELECT CURRENT_TRANSACTION FROM RDB$DATABASE`
Las transacciones aseguran consistencia, seguridad (si algo falla se puede volver al comienzo) y permite aislamiento (cada usuario trabaja sin interferir con otros- se relaciona con el tema de concurrencia).

---
### Multiversion Concurrency Control

Firebird trabaja con Multiversion Concurrency Control: 
- No bloquea lecturas (no se pueden usar semaforos) 
- Cada transacción ve su propia versión de los datos
- Los cambios no afectan hasta otros hasta hacer COMMIT

Firebird se maneja con versiones propias y no bloqueos clasicos
“Versiones propias” = cada cambio genera una nueva versión del dato
“Sin bloqueos clásicos” = no depende de locks para permitir concurrencia, sino de esas versiones, evitando que transacciones se bloqueen entre sí

NIVELES DE AISLAMIENTO:
En Firebird los niveles de aislamiento determinan qué versión de los datos ve una transacción y cómo se comporta frente a concurrencia. Los principales son Snapshot y Read Committed.

![[niveles-aislamiento.png]]![[use-cases-aislamiento.png]]