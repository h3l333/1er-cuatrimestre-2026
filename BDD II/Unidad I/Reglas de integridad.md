>Conditions that guarantee that the stored data makes sense according to the logic of the real world that the DBMS represents.
>Beyond assuring that the information is valid in a technical sense, it also assures cohesion with the "meaning" of the business and the system.

- Integridad
- Semántica

### Semántica

Ejemplos:

>Edád valida (mayor que 0 y menor que 120)
>Salario (no puede ser negativo)
>Inscripción (un alumno solo puede inscribirse a materias de su carrera)

*Cómo se implementan?*

- CHECK constraints ([[CHECK constraints]])
- Triggers ([[Triggers]])
- Procedimientos almacenados
- Reglas de negocio en la app

>Existen [[Distintos tipos de integridad]].

### Tabla comparativa

|**Tipo de integridad**|**Qué asegura**|**Ejemplo**|
|---|---|---|
|**Integridad de entidad**|Cada registro de una tabla debe tener una clave primaria única y no nula.|En una tabla **Alumno**, el **id_alumno** no puede repetirse ni ser **NULL**.|
|**Integridad referencial**|Las claves foráneas deben coincidir con una clave primaria existente en otra tabla.|Un **id_cliente** en **Pedidos** debe existir en la tabla **Clientes**.|
|**Integridad semántica**|Los datos deben respetar reglas del negocio o del mundo real.|Un salario no puede ser negativo; la fecha de fin debe ser mayor que la de inicio.|

