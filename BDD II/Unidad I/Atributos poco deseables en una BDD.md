- Redundancia
- Repetición
- Imposibilidad en recuperar cierta información
- Imposibilidad en representar cierta información

Suponer la siguiente table no normalizada ([[Normalización 2F a 3F]]), mal diseñada:

```
Enrollments(
    StudentID,
    StudentName,
    StudentEmail,
    CourseID,
    CourseName,
    ProfessorName,
    ProfessorOffice
)
```

---
### Redundancia

Por ejemplo, si un curso tiene muchos estudiantes, se repite información innecesariamente.

| StudentID | StudentName | CourseID | CourseName | ProfessorName |
| --------- | ----------- | -------- | ---------- | ------------- |
| 101       | Ana         | CS101    | Databases  | Dr. Smith     |
| 102       | Luis        | CS101    | Databases  | Dr. Smith     |
| 103       | Maria       | CS101    | Databases  | Dr. Smith     |

---
### Repetición

Por ejemplo, se repiten los datos de un estudiante por cada curso en que está inscripto.

|StudentID|StudentName|CourseID|
|---|---|---|
|101|Ana|CS101|
|101|Ana|CS102|
|101|Ana|CS103|

---
### Imposibilidad de representación

Suponiendo el esquema anterior, si añadimos un nuevo curso al que no hay alumnos inscriptos, es imposible representar la información siguiente:

- CourseID = CS104  
- CourseName = AI  
- Professor = Dr. Lee

El problema surge cuándo intentamos insertar datos en la tabla. Se le llama una "insertion anomaly".

---
### Imposibilidad de recuperar cierta info.

Suponer que se da de baja un único estudiante inscripto a un curso:

|StudentID|StudentName|CourseID|CourseName|
|---|---|---|---|
|101|Ana|CS101|Databases|

Al eliminarse al estudiante, se pierden todos los datos sobre el curso pese a que el curso aún existe. A esto se le llama una "deletion anomaly".