Si retornan tantos 'ok' (los nodos de la BDD distribuida) como hay nodos en la red que debo actualizar, se le da COMMIT (recordar codigo 404).
Cliente-servidor: El cliente envía una solicitud al servidor de Firebird (generalmente al puerto 3050), que contiene una sentencia SQL o una operación preparada. El servidor recibe la petición a través de su protocolo, la interpreta y la ejecuta en el motor de base de datos, devolviendo el resultado al cliente.

--- 

Que es ORM?
>Object-Relational Mapping (ORM) is a programming technique that acts as a bridge between object-oriented code and relational databases. It allows developers to create, read, update, and delete data using programming language objects (e.g., Python, Java) instead of writing raw SQL queries, improving productivity, security, and code maintainability.

- En Firebird una autonomous transaction es una transacción que: Se ejecuta independientemente de la transacción principal; tiene su propio ciclo de vida (START, COMMIT, ROLLBACK)
	- No se ve afectada por lo que pase con la transacción que la invoca

- Si todo va bien se hacen los deletes tanto en la BDD local como en la remota
- Si algo sale mal, puede que: Se realiza la transaccion en la BDD local que dispara una operacion en la remota. Algo falla en la op. local, se hace un rollback. Se completa la transaccion remota y las BDD quedan inconsistentes. Se hace la transaccion local pero falla la conexion a la remota. Inconsistencia.
  
![[secuencia-common-transaction.png]]
![[common-transaction-desc.png]]

Que es la replicacion en tiempo real?
La replicación en tiempo real es un mecanismo donde los cambios realizados en una base de datos se propagan casi inmediatamente a otra base de datos (o varias), manteniéndolas sincronizadas.
“Tiempo real” no es lo opuesto de “asincrónico”.

Relación correcta:

- Tiempo real -> qué tan rápido se replica
- Sincrónico / asincrónico -> cuándo se confirma la transacción
  
![[tiempo-real-vs-diferida.png]]

---
*"Mi profesor dice que si en dos nodos de una red usas distintos motores de BDD y deseas realizar una transaccion entre ellos, hay que tener un "framework" en el medio"*
![[framework-transaction-manager.png]]