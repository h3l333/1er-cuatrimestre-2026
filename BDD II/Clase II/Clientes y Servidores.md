**Client**
>A client is an application or user interface that sends requests to the database. It does not manage data storage directly. Examples include web apps, desktop software, or scripts that issue SQL queries.

**Server**
>The server is the DBMS system that stores, processes, and manages the database. It handles query execution, transaction control, concurrency, security, and data integrity. ([[Reglas de integridad]])

**Interaction**
>The client sends a request such as an SQL query. The server processes it, accesses the database, and returns the result. This separation allows multiple clients to access the same database efficiently and securely.