Group of functional dependencies ([[Dependencias Funcionales]]) equivalent to the original set of dependencies given, but simplified to the maximum (minimal cover or canonical cover).

The minimal cover Fmin of a set of functional dependencies F satisfies the following conditions:

1. Equivalencia: Satisfies the same dependencies as F.
2. Simple right sides: Each dependency has only one attribute on it's right side.
3. No redundant attributes: No unnecessary attributes on the left sides. ([[Clausura de Atributos]])
   We use "attribute clauses":
   
   - Suppose "X'" just means "a subset of X that results when removing an attribute we are 'testing for'".
   - From X', using the functional dependencies contained in F, we test what attributes we can obtain.

Algoritmo de Juanca para su obtención:
![[algoritmo-juanca.png]]
   