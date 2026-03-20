function splitStringUsingForLoop(str, n) {
	let segments = [];
	for (let i = 0; i < str.length; i += n) {
		segments.push(str.slice(i, i + n));
	}
	return segments;
}

const iterarDependencias = (dependencias, clausuraAtributos) => {
	// Chequeo si en la dependencia los caracteres a la izquierda estan todos en la clausura
	dependencias.forEach((dependencia) => {
		// Extraigo caracteres a la izquierda
		let izquierda = splitStringUsingForLoop(dependencia.split(" -> ")[0], 1);
		let estanTodos = true;
		for (let i = 0; i < izquierda.length; i++) {
			estanTodos = estanTodos && clausuraAtributos.includes(izquierda[i]);
		}
		if (estanTodos) {
			// Aniado a la clausura el lado derecho de la dependencia
			const derecha = splitStringUsingForLoop(dependencia.split(" -> ")[1], 1);
			derecha.forEach((atr) => {
				if (!clausuraAtributos.includes(atr)) {
					clausuraAtributos.push(atr);
				}
			});
			console.log(
				"Lado derecho:",
				splitStringUsingForLoop(dependencia.split(" -> ")[1], 1),
			);
			console.log("Clausura actual:", clausuraAtributos);
		}
	});
};

const devolverClausura = (dependencias, atributos) => {
	let clausuraAtributos = splitStringUsingForLoop(atributos, 1); // Por reflexividad
	// Aplico transitividad
	let cambio = false;
	do {
		let longitudAntes = clausuraAtributos.length;
		// Bloque de codigo en donde clausuraAtributos cambia o no
		iterarDependencias(dependencias, clausuraAtributos);
		cambio = longitudAntes != clausuraAtributos.length ? true : false;
	} while (cambio);
	return clausuraAtributos;
};

const dependenciasTest = [
	"A -> B",
	"B -> C",
	"AC -> D",
	"D -> E",
	"EF -> G",
	"G -> H",
];
const atributosTest = "AE";
console.log(devolverClausura(dependenciasTest, atributosTest));
