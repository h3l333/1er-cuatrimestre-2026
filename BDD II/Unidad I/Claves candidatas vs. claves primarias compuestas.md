- The main difference between a candidate key and a composite primary key is that composite primary keys are primary keys made up of multiple attributes that are unique to each table, meaning that one table can only have one. 
	- Example: A table of "Inscripciones" where the composite key is made up of Matricula + Cod_Materia.
- Candidate keys on the other hand merely refer to a set of attributes within a table that uniquely identify a register within a table, for example, let's suppose:

```
CREATE TABLE Appointments (
    ClientID int not null,
    CounsellorID int not null,
    RoomID int not null,
    AppointmentTime datetime not null
)
```

The candidate keys for this table are {ClientID,AppointmentTime}, {CounsellorID,AppointmentTime} and {RoomID,AppointmentTime}. Any of those combinations of columns could be used to uniquely identify a row in the table, and all of them are composite keys.

Which one we choose to declare as primary key will depend (probably) on our own interpretation of the main "focus" of the system. Are we mainly concerned with Room usage, or Clients, or Counsellors? In any case, we'll select one and declare it the primary key. We'll also hopefully declare the other keys as unique constraints.

>A table can have multiple groups or pairs of candidate keys ([[Claves candidatas]]), but only one composite primary key ([[Claves primarias]]).