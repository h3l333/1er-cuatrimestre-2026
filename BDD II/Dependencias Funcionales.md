
Describen cómo unos atributos determinan a otros.
Representan restricciones entre dos colecciones de atributos. 

### Relational schema:

>Describes formally the structure of a relation or table in a relational database, including name, attributes and domains/types (sometimes).

Basic form: R(A1, A2, A3, ..., An)

Where R is the relation and A, A1, An are the attributes

Example: Student(ID, Name, Email, Age)

>tuple = row

A functional dependency occurs when the value of an attribute or set of attributes uniquely determines the value of *another attribute* or *multiple attributes*. This relationship is denoted as X -> Y. To represent this relationship, we have two main "features": the left (determinant) and right side (dependent attributes) of the arrow.

***Basic Example***

- Student(ID, Name, Email) (relation schema)
- ID -> Name, Email (functional dependency)

