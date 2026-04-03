![[automata-finito-grafo.png]]![[automata-finito-ejemplo.png]]

>Ways of representing states in languages and transitions caused by the symbols present in the language:

- DFA: deterministic transitions, one path
- NFA: multiple possible transitions, many paths
- Minimal DFA: optimized DFA with no redundant states

*El autómata finito mínimo siempre es único.*

Reminder: Kleene's closure of a language L is denoted as L* and represents the set of all possible strings formed by concatenated 0 or more strings from L, including the empty string.

---
## Thompson's algorithm: 

- Set of "building blocks" used to turn a regular expression into a Non-deterministic Finite Automaton. It simplifies the "verification" of a string in any given language through modularization.

([[Practica III Solución]])
([[Corrección Ej. III]])