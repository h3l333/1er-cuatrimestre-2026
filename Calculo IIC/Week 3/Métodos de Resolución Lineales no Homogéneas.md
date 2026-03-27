Para una ecuación diferencial lineal de primer orden de la forma $y' + p(x)y = q(x)$, existen principalmente **tres caminos** para llegar a la solución general ([[Soluciones de las EDO]]).

Aunque el resultado final es el mismo, cada método ofrece una perspectiva distinta sobre cómo "desarmar" la ecuación.

---
### 1. Factor Integrante (El método más estándar)

Este es el método "caballito de batalla". Se basa en encontrar una función $\mu(x)$ que, al multiplicar toda la ecuación, convierte el lado izquierdo en la derivada de un producto.

- **Paso 1:** Calculás el factor integrante:
$$\mu(x) = e^{\int p(x) \, dx}$$
- **Paso 2:** Multiplicás toda la ecuación por $\mu(x)$. El lado izquierdo se convierte automáticamente en $(\mu(x) \cdot y)'$.

- **Paso 3:** Integrás ambos lados:
$$\mu(x) \cdot y = \int \mu(x) \cdot q(x) \, dx + C$$
- **Paso 4:** Despejás $y$.

---
### 2. Variación de Parámetros (Método de Lagrange)

Este método es muy potente porque es el mismo que se usa para ecuaciones de orden superior (como las de segundo orden que mencionamos antes).

- **Paso 1:** Resolvés la **homogénea asociada** ($y' + p(x)y = 0$). La solución será $y_h = C \cdot e^{-\int p(x) \, dx}$.

- **Paso 2:** Suponés que la constante $C$ es en realidad una función $u(x)$. Es decir, buscás una solución de la forma:
$$y_p = u(x) \cdot e^{-\int p(x) \, dx}$$
- **Paso 3:** Derivás $y_p$, reemplazás en la ecuación original y despejás $u'(x)$.

- **Paso 4:** Integrás $u'(x)$ para hallar $u(x)$ y reconstruís la solución.

---
### 3. Método de Sustitución (Bernoulli simplificado)

A veces se enseña como el método de "proponer el producto" ($y = u \cdot v$). Es muy intuitivo si te gusta el álgebra de manipulación.

- **Paso 1:** Proponés que la solución es el producto de dos funciones: $y(x) = u(x)v(x)$.

- **Paso 2:** Sustituís en la ecuación: $u'v + uv' + p(x)uv = q(x)$.

- **Paso 3:** Agrupás términos: $u(v' + p(x)v) + u'v = q(x)$.
  
- **Paso 4:** Forzás que el paréntesis sea cero ($v' + p(x)v = 0$). Esto te da una función $v(x)$ fácil de hallar (es una lineal homogénea).

- **Paso 5:** Con ese $v(x)$, la ecuación te queda $u'v = q(x)$, de donde integrás para sacar $u(x)$.

## Fórmula Resolvente

Si tenés la ecuación en su forma estándar, la solución general es:
$$y(x) = \frac{1}{\mu(x)} \left[ \int \mu(x) \cdot Q(x) \, dx + C \right]$$
Donde el factor integrante es: **$\mu(x) = e^{\int P(x) \, dx}$**.

### Pasos:

- **Normalizar:** Asegurate de que $y'$ no tenga nada multiplicando (si lo tiene, dividí toda la ecuación por ese término).

- **Identificar:** Identificá quién es $P(x)$ (lo que acompaña a la $y$) y quién es $Q(x)$ (el término solo).

- **Calcular $\mu(x)$:** Resolvé la integral $e^{\int P(x) \, dx}$.

- **Sustituir:** Meté todo en la fórmula resolvente y resolvé la integral que quedó adentro del corchete.