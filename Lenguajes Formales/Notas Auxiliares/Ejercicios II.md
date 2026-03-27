Escribir expresiones regulares que definan los siguientes lenguajes:

1. Codigos postales. 

![[lenguajes-regulares.png]]
![[verificacion-lenguaje.png]]

>Un lenguaje puede ser infinito y regular. La regularidad no se trata de la cantidad de cadenas que contiene sino si un autómata finito lo puede reconocer o no.

Tomando la expresión regular `a*b^+ | cd (cdcd)^+`,
Una cadena debe adherirse a uno de los dos lados de la clausula, por ejemplo:

Puede no tener ninguna a pero debe tener al menos una b O debe empezar con "cd" y contener "cdcd" al menos una vez.
- bb
- aaab
- cdcdcd
- cdcdcdcdcdcd
Son todas opciones válidas.

Escribiendo la expresión regular del ejercicio:
>L = 1 . (0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9)^3
>O, alternativamente: L = 1 . [0 - 9]^3