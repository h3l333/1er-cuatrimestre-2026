1) El lenguaje es regular. Lo verificamos observando su expresión regular:
- { {01} . {01}^+ } | {11}* -> x
- {0} . {0}^+ -> y

>L = { { {01} . {01}^+ } | {11}* } . {#} . { {0} . {0}^+}

Al tratarse de concatenaciones de lenguajes regulares ({0} y {1}), podemos asegurar que L es un lenguaje regular.

2) M = {0} . {b} . {0 | 1}^+

([[Practica II]])
([[Ejercicios II]])
([[Practica III Solución]])