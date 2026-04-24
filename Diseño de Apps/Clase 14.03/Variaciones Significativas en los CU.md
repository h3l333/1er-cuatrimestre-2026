([[Qué es un CU y que no es un CU]])
Supongamos el CU:

Retirar dinero

Escenario principal (cajero humano en ventanilla):

1. Cliente solicita retiro al cajero  
2. Cajero verifica la cuenta  
3. Cajero entrega el dinero  
4. Sistema registra la operación

Variación significativa: **cajero automático (ATM)**

1. Cliente inserta tarjeta  
2. Cliente ingresa PIN  
3. Cliente selecciona retirar dinero  
4. Sistema verifica saldo  
5. ATM entrega el dinero  
6. Sistema registra la operación

La **funcionalidad es la misma** (retirar dinero), pero **el modo de interacción cambia significativamente**.

Conceptualmente:

Caso de uso: Retirar dinero  
    ├─ Escenario: ventanilla con cajero humano  
    └─ Escenario: cajero automático

Por qué es una variación significativa

Porque cambia:

- **la interacción con el sistema**
- **los pasos del flujo**    
- **el actor que participa**
    
Pero **el objetivo del CU sigue siendo el mismo**.

La funcionalidad del sistema no cambia: **retirar dinero de una cuenta**.