Los axiomas de armstrong nos permite deducir [[Dependencias Funcionales]] a partir de otras ya existentes en el esquema relacional.

---

![[armstrongs-axioms.png]]

---
Dado un conjunto de dependencias F, un algoritmo que calcula F+ aplicando los axiomas de Armstrong debería devolver F+.

![[conjunto-dependencias.png]]

### Pseudocódigo

```
F+ = F;

repeat for each (dependencia funcional f de F+)
{
	// aplicar reglas de reflexividad
	// y aumentatividad al conjunto F
	// y añadir las dependencias
	// funcionales resultantes a F
	
	for each (pareja de dependencias funcionales f1 y f2 de F+)
	{
		if (f1 y f2 pueden combinarse mediante la transitividad)
		{
			// añadir la dependencia
			// funcional resultante a F+
		}
	}
} until (F+ no cambie más)
```

Si para un conjunto de atributos alfa el resultado coincide con F+, entonces es superclave. Si no, no. ([[Superclaves]])