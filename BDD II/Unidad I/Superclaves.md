Formal definition of a super key using functional dependencies ([[Dependencias Funcionales]]):

>A group of attributes K is a super key if knowing K we are able to know a set of attributes. It doesn't matter if K has "extra" attributes that aren't unique identifiers, so long as the prior condition applies.

![[super-candidate-primary.png]]

Usando álgebra relacional:

>Suponiendo R = {A1, A2, ..., An}...
>Un conjunto de atributos pertenecientes a R para las que no hay un par de tuplas t1 y t2 tal que t1[S] = t2[S].

![[super-keys.png]]

![[comparative-table-keys.png]]

Si alfa+ coincide con R, es superclave. Si no no.

![[alfa-clave.png]]