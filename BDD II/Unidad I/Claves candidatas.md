A "candidate key" is a group of one or more attributes that can identify in a unique manner each register (row) within a table.

*To be a candidate key, an attribute must:*
- Be unique for each row; no two rows can have the same value for that key.
- Minimal: if a key is composed of multiple fields, none can be eliminated without the key losing it's capability of uniquely identifying each register.

They differ from super keys ([[Superclaves]]) in the sense that a super key is ***not necessarily minimal***, a super key may have extra attributes that are not required for uniqueness, such as a first name.

>A candidate key is a super key, but not all super keys are candidate keys. Example:

- Super key A: {ID_User, Name} (It's a super key because the user ID allows for unique identification of a row, and it ISN'T a candidate key because it is not minimal.)

>A candidate key is always a super key because it allows for the unique identification of any one register.

![[super-candidate-primary.png]]

![[BDD II/Imagenes/comparative-table-keys.png]]

>Other attributes within a table depend on any one set of candidate keys ([[Dependencias Funcionales]]).