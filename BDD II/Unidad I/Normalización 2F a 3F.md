Una tabla en 2F tiene atributos atómicos y carece de dependencias parciales. Supongamos la siguiente tabla en la 2da forma normal (no hay dependencia parcial porque la clave es no compuesta ([[Claves candidatas vs. claves primarias compuestas]]), está hecha de un solo atributo):

```
Employees(
    EmployeeID,
    EmployeeName,
    DepartmentID,
    DepartmentName
)
```

No está en la 3ra forma normal debido a la siguiente dependencia transitiva:

- EmployeeID -> DepartmentID -> DepartmentName

Podemos llevarla a la 3ra forma "diviendo" las tablas así:

```
Employees(  
EmployeeID PRIMARY KEY,  
EmployeeName,  
DepartmentID FOREIGN KEY  
)
```

```
Departments(  
DepartmentID PRIMARY KEY,  
DepartmentName  
)
```

>Una tabla está en la 3ra forma normal si todos los atributos no claves dependen directamente de la clave primaria ([[Claves primarias]]).