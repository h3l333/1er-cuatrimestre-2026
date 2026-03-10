- Superclaves [[BDD II/Superclaves]]
- Claves candidatas
- Atributos primos y no primos
- Propiedades indeseables
	- Redundancia
	- Repetición
	- Imposibilidad de **representar** info.
	- Imposibilidad de **recuperar** info.
- Dependencias funcionales y su utilidad [[BDD II/Dependencias Funcionales]]
- Dependencias funcionales triviales
- Dependencias funcionales deducidas usando las reglas de Armstrong
- Las reglas de Armstrong
	- Reflexividad
	- Aumentatividad
	- Transitividad
	- Reglas adicionales
		- de la unión
		- de la descomposición
		- pseudotransitividad
- Conjuntos de dependencias funcionales F y F+
- Procedimiento para calcular F+
- Comprobación de una superclave, algoritmo para el cálculo de a+
- Descomposición
- Formas normales

# Videos de YouTube

- 1- https://youtu.be/DAN2XIwz6tQ?si=TtDXKqXDjhmF1Eu3
- 2- https://youtu.be/qn--k8Nidak?si=v0ROtCEnTsYUX7fu

# Resumen preliminar realizado con inteligencia artificial

>En el diseño de bases de datos relacionales se usan **dependencias funcionales** para describir cómo unos atributos determinan a otros. Con ellas se pueden identificar **superclaves**, que son conjuntos de atributos que determinan toda la relación, y **claves candidatas**, que son las superclaves mínimas. Los atributos que pertenecen a alguna clave candidata son **atributos primos**, y los demás son **no primos**.
>Las dependencias funcionales pueden ser **triviales** o derivarse de otras usando **las reglas de Armstrong** (reflexividad, aumentatividad y transitividad), junto con reglas derivadas como **unión, descomposición y pseudotransitividad**. A partir de un conjunto de dependencias FFF se puede obtener su **cierre F+F^+F+**, que contiene todas las dependencias deducibles. Esto se calcula aplicando sistemáticamente esas reglas.
>También se usa el **cierre de atributos X+X^+X+** para verificar si un conjunto de atributos es **superclave**. Estas herramientas ayudan a detectar **propiedades indeseables** en el diseño, como **redundancia, repetición de datos o anomalías que impiden representar o recuperar información correctamente**.
>Para eliminar estos problemas se aplica la **descomposición**, que divide una relación en varias tablas más pequeñas manteniendo la información correcta.
