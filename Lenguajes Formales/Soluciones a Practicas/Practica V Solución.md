1)
a) Para L1:

- Elementos no terminales: S, X
- Elementos terminales: a, b, c, d
- Símbolo distinguido: S
- Reglas:
	- S -> cXbb
	- X -> aXb | d

b) Para L2: 

- Elementos no terminales: S, X, Y, Z
- Elementos terminales: 0, 1
- Símbolo distinguido: S
- Reglas:
	- S -> 0 | X0
	- X -> YZ
	- Y -> 1 | Y1
	- Z -> 0 | Z0

c) Para L3: 

- Elementos no terminales: S, X, Y
- Elementos terminales: a, b, c, e
- Símbolo distinguido: S
- Reglas:
	- S -> aX
	- X -> cc | Ycc | aXe
	- Y -> bcc | bYcc

d) Para L4:

- Elementos no terminales: S, X, Y, Z, Q
- Elementos terminales: a, b, c, e
- Símbolo distinguido: S
- Reglas:
	- S -> aX
	- X -> cce | Ye
	- Y -> aZe | Ze | Ye
	- Z -> cc | Qcc
	- Q -> bcc | bQcc

2) Supongo que se tratan de constantes enteras y que los identificadores sólo usan nros.

- Elementos no terminales: S, A, B, C, D, E
- Elementos terminales: `F, I, L. T, E, R, (, ), [, ], ,, _, ;, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0`
- Símbolo distinguido: S
- Reglas:
	- S -> FILTER(`_A ; [B]`)
	- A -> `>C | <C`
	- B -> D | $\lambda$
	- D -> C, D | C
	- C -> CE | E
	- E -> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0