a.
![[practica_4_a.png]]

Estados Q: {q0, q1, q2, q3, q4, q5, q6}
Sigma alfabeto: {a, b}
Alfabeto de la pila: {Z, A}
Delta función de transiciones:
- δ(q0, a, Z) = {(q1, Z)}
- δ(q1, a, Z) = {(q2, Z)}
- δ(q2, a, Z) = {(q3, Z)}
- δ(q3, a, Z) = {(q4, AZ)}
- δ(q3, λ, Z) = {(q5, Z)}
- δ(q4, a, A) = {(q4, AA)}
- δ(q4, b, A) = {(q6, λ)}
- δ(q6, b, A) = {(q6, λ)}
- δ(q6, λ, Z) = {(q5, Z)}
Estado inicial: {q0}
Estados finales o de aceptación: {q5}
Símbolo distinguido Z0 = {Z}

---

b.
![[practica_4_b.png]]

Estados Q: {q0, q1, q2, q3}
Sigma alfabeto: {a, b}
Alfabeto de la pila: {Z, N}
Delta función de transiciones:
- δ(q0, a, Z) = {(q1, NZ)}
- δ(q0, b, Z) = {(q3, Z)}
- δ(q1, a, N) = {(q1, NN)}
- δ(q1, b, N) = {(q2, λ)}
- δ(q2, b, N) = {(q2, λ)}
- δ(q2, b, Z) = {(q3, Z)}
- δ(q3, b, Z) = {(q3, Z)}
Estado inicial: {q0}
Estados finales o de aceptación: {q3}
Símbolo distinguido Z0 = {Z}

---

c.
![[practica_4_c.png]]

Estados Q: {q0, q1, q2, q3}
Sigma alfabeto: {a, b}
Alfabeto de la pila: {Z, N}
Delta función de transiciones:
- δ(q0, a, Z) = {(q1, NZ)}
- δ(q0, λ, Z) = {(q3, Z)}
- δ(q1, a, N) = {(q1, NN)}
- δ(q1, b, N) = {(q2, λ)}
- δ(q2, b, N) = {(q2, λ)}
- δ(q2, λ, Z) = {(q3, Z)}
- δ(q3, b, Z) = {(q3, Z)}
Estado inicial: {q0}
Estados finales o de aceptación: {q3}
Símbolo distinguido Z0 = {Z}

---

d.
![[practica_4_d.png]]

Estados Q: {q0, q1, q2, q3}
Sigma alfabeto: {a, b}
Alfabeto de la pila: {Z, N}
Delta función de transiciones:
- δ(q0, a, Z) = {(q0, NZ)}
- δ(q0, a, N) = {(q1, NN)}
- δ(q1, a, N) = {(q1, NN)}
- δ(q0, λ, N) = {(q3, λ)}
- δ(q2, b, N) = {(q2, λ)}
- δ(q2, b, N) = {(q2, λ)}
- δ(q2, λ, N) = {(q3, λ)}
Estado inicial: {q0}
Estados finales o de aceptación: {q3}
Símbolo distinguido Z0 = {Z}

---

e.
![[practica_4_e.png]]

Estados Q: {q0, q1, q2, q3}
Sigma alfabeto: {a, b}
Alfabeto de la pila: {Z, N}
Delta función de transiciones:
- δ(q0, a, Z) = {(q0, NZ)}
- δ(q0, a, N) = {(q1, NN)}
- δ(q0, λ, N) = {(q3, λ)}
- δ(q0, λ, Z) = {(q3, Z)}
- δ(q1, a, N) = {(q1, NN)}
- δ(q1, b, N) = {(q2, λ)}
- δ(q2, b, N) = {(q2, λ)}
- δ(q2, λ, Z) = {(q3, Z)}
Estado inicial: {q0}
Estados finales o de aceptación: {q3}
Símbolo distinguido Z0 = {Z}

---

f.
![[practica_4_f.png]]

Estados Q: {q0, q1, q2, q3, q4, q5, q6, q7}
Sigma alfabeto: {1, b, d, c, 0}
Alfabeto de la pila: {Z, N, B}
Delta función de transiciones:
- δ(q7, 1, λ) = {(q0, λ)}
- δ(q0, λ, λ) = {(q1, λ)}
- δ(q0, 1, Z) = {(q1, NZ)}
- δ(q1, 1, N) = {(q1, NN)}
- δ(q1, b, Z) = {(q2, BZ)}
- δ(q1, b, N) = {(q2, BN)}
- δ(q2, b, B) = {(q2, BB)}
- δ(q2, d, λ) = {(q3, λ)}
- δ(q2, λ, λ) = {(q4, λ)}
- δ(q3, d, λ) = {(q3, λ)}
- δ(q3, λ, λ) = {(q4, λ)}
- δ(q4, c, B) = {(q4, λ)}
- δ(q4, c, N) = {(q5, N)}
- δ(q4, c, Z) = {(q6, Z)}
- δ(q5, 0, N) = {(q5, λ)}
- δ(q5, λ, λ) = {(q6, λ)}
Estado inicial: {q7}
Estados finales o de aceptación: {q6}
Símbolo distinguido Z0 = {Z}