>Técnica para analizar y especificar comportamiento de un sistema o una parte de él.

- Describe qué hace pero no cómo
- Los CU SIEMPRE están vistos por el actor ([[Qué es un CU y que no es un CU]])

## Quién es el actor?

- El que inicia el CU
- Los CU y las [[Máquinas de estados]] se asocian de la siguiente manera:
  El actor ejecuta/inicia un CU -> el CU genera un evento -> el evento cambia el estado de un objeto descripto por una ***máquina de estados***

*La máquina de estados modela los estados y transiciones de un objeto (o instancia de una clase) a lo largo de su ciclo de vida.*

>Por ejemplo: 

Objeto: **Pedido**

La máquina de estados modela **cómo cambia el estado del pedido durante su vida**.

- Estados posibles del pedido:

```
creado
pagado
enviado
entregado
cancelado
```

- Eventos que cambian el estado:

```
confirmar_pago
enviar_pedido
confirmar_entrega
cancelar_pedido
```

---

Un sensor, por ejemplo, puede ser un actor no humano. Un actor es cualquier entidad externa que interactúa con el sistema siendo modelado. Timer es otro ejemplo.