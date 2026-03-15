Es un procedimiento estandar en la normalización ([[Normalización 2F a 3F]]) en los sistemas de BDD.

Normalization processes such as **Second Normal Form**, **Third Normal Form**, and **Boyce-Codd Normal Form** rely on **decomposing relations into smaller relations**.

### Purpose

During normalization, a relation that violates a normal form is **decomposed into two or more relations** so that the violations disappear. The goals are:

- eliminate redundancy
- remove update anomalies
- enforce functional dependencies properly

Existen las [[Descomposiciones con Pérdida]].

NOTE: We must associate two tables with a foreign key that references a unique attribute. It must reference a candidate key. ([[Claves primarias]])

### Reconstruction

>Reconstruction: Recovering the original relation using **natural joins**.