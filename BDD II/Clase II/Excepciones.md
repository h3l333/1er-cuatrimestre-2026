>In Firebird PSQL, an exception is a user-defined error object that can be raised to abort execution of a statement and roll back the operation, returning a custom error message.

1. **Create the exception**

```
CREATE EXCEPTION STOCK_INVALIDO 'Stock insuficiente';
```

2. **Create the trigger**

- The trigger references that exception
- If the exception does not exist yet, the trigger creation will fail

3. **Use the exception inside the trigger**

```IF (condition) THEN  
  EXCEPTION STOCK_INVALIDO;
```

Effect:

- When the condition is met, execution stops immediately
- The INSERT or UPDATE is rolled back
- The error message is returned

So the model is:

- Exception = definition of the error
- Trigger = logic that decides when to raise it ([[Triggers]])

>Las excepciones abortan las operaciones siendo realizadas. Tratese de un insert, update, delete, etc. La señaliza al motor para que aborte.