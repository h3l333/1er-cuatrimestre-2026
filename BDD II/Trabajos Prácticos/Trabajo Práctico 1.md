
1. Implementación Generator sobre tabla para generar ID en forma automática. ([[Generators]])

```
CREATE GENERATOR gen_id_prod;
SET GENERATOR gen_id_prod TO 0;
```

Al utilizar Firebird, usamos el símbolo ```^``` para temporalmente cambiar el delimitador de instrucciones asi las declaraciones SQL referentes a los disparadores se pueden escribir e implementar. Dice: "No ejecutes nada hasta que veas el símbolo ^".

```
SET TERM ^ ; -- Esto le comunica al cliente que ahora las sentencias terminan con ^ en lugar de ;
ALTER TRIGGER trg_bi_prod FOR PRODUCTO ACTIVE
BEFORE INSERT POSITION 0
AS BEGIN
	NEW.ID = GEN_ID();
SET TERM ; ^ -- Esto le comunica al cliente que vuelva a cambiar el delimitador a ;
```

- ```ALTER TRIGGER [disparador]``` modifica o redefine un disparador. Usamos CREATE si es que lo estamos creando por primera vez.
- `POSITION 0` define el orden de ejecución. Si tuvieras varios triggers para el mismo evento (`BEFORE INSERT`), el de posición `0` se ejecuta primero.
- `AS BEGIN ... END` delimitan el bloque de código procedural que se ejecutará.

Vale mencionar que se requiere emitir un error o excepción cuándo se pretende cambiar el valor de la columna ID:

```
CREATE EXCEPTION ex_prod1 -- Mensaje que luego puede ser 
```