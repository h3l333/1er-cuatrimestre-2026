>Una **máquina de estados** (finite state machine, FSM) es un modelo de diseño donde un sistema solo puede estar en **un estado a la vez**, y cambia a otro estado cuando ocurre un **evento o condición**.

Un semáforo, por ejemplo es una máquina de estados.
Citas de Reddit:

- "Here's a simple example of a practical state machine in video games: [https://howtomakeanrpg.com/r/a/state-machines.html](https://howtomakeanrpg.com/r/a/state-machines.html)
  Many video games have glitches where you can e.g. duplicate an item by dropping and grabbing an item at the same time, or finish a level and die at the same time, which speedrunners love to take advantage of.
  If the games were more explicit about which state the player was currently in and which state those states can lead to, then you avoid a lot of bugs like that."

- A state machine is basically just a thing that can be in different states. There are various actions that can cause it to change states. Typically they are drawn as a series of states with circles, and then the actions that can change the state from one to the next.

---
### MDN Explanation

_Figure 1: Deterministic Finite State Machine._

![The machine transitions from state 1 to state 2 for input X and from state 1 to state 3 for input Y](https://developer.mozilla.org/en-US/docs/Glossary/State_machine/statemachine1.png)

In _Figure 1_, the state begins in State 1; the state changes to State 2 given input 'X', or to State 3 given input 'Y'.

_Figure 2: Non-Deterministic Finite State Machine._

![The machine may remain in state 1, transitioning to itself, or may transition from state 1 to state 2 for input X](https://developer.mozilla.org/en-US/docs/Glossary/State_machine/statemachine2.png)

In _Figure 2_, given input 'X', the state can persist or change to State 2.