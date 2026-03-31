import {
	splitStringUsingForLoop,
	devolverClausura,
	iterarDependencias,
} from "./calculo-clausura-conjunto.js";

const dependencias = [
	"A -> B",
	"B -> C",
	"AC -> D",
	"D -> E",
	"EF -> G",
	"G -> H",
];

const convertirFormatoEstandar = (dependencias, cubrimientoMinimal) => {
	dependencias.forEach((dependencia) => {
		let derecha = splitStringUsingForLoop(dependencia.split(" -> ")[1], 1);
		derecha.forEach((atr) => {
			if (
				!cubrimientoMinimal.includes(
					`${dependencia.split(" -> ")[0]} -> ${atr}`,
				)
			) {
				cubrimientoMinimal.push(`${dependencia.split(" -> ")[0]} -> ${atr}`);
			}
		});
		// Eliminar si tiene mas de dos atributos a la izquierda
		let izquierda = splitStringUsingForLoop(dependencia.split(" -> ")[0], 1);
		if (izquierda.length > 1)
			cubrimientoMinimal.filter((dep) => dep != dependencia);
	});
	return cubrimientoMinimal;
};

const resolverTransitivas = (dependencias) => {
	let resultado = [...dependencias];

	for (let i = 0; i < dependencias.length; i++) {
		let dependencia = dependencias[i];
		let izq = dependencia.split(" -> ")[0];
		let der = dependencia.split(" -> ")[1];

		// Ver que atributos determina el lado derecho, filtro por el atributo "mismo"
		let clausuraDer = devolverClausura(dependencias, der).filter(
			(atr) => atr != der,
		);
		//console.log("Clausula der: ", clausuraDer);
		// Para cada atributo en la clausura, si existe en 'dependencias' una dependencia tal que izq -> atr. der, eliminarla
		for (let j = 0; j < clausuraDer.length; j++) {
			if (dependencias.includes(`${izq} -> ${clausuraDer[j]}`)) {
				resultado = resultado.filter(
					(dep) => dep != `${izq} -> ${clausuraDer[j]}`,
				);
				//console.log("Resultado: ", resultado);
			}
		}
	}
	return resultado;
};

// Si dentro de unos atributos determinantes, un atributo determina a otro o a los otros, sacar los innecesarios

const eliminarDeterminantesAutodeterminantes = (cubrimientoMinimal) => {
	let resultado = [...cubrimientoMinimal];

	for (let i = 0; i < cubrimientoMinimal.length; i++) {
		let izq = cubrimientoMinimal[i].split(" -> ")[0];
		let nuevaDep = cubrimientoMinimal[i];
		for (let j = 0; j < izq.length; j++) {
			let clausuraAtr = devolverClausura(cubrimientoMinimal, izq[j]);
			for (let h = 0; h < izq.length; h++) {
				if (
					izq[h] != izq[j] &&
					clausuraAtr.includes[izq[h]]
				) // Saco el atributo que el atributo determina
				{
					nuevaDep = `${[...izq].filter((atr) => atr != izq[h]).join("")}`;
				}
			}
		}
	}

	return resultado;
};

const verificarRedundancias = (cubrimientoMinimal) => {
	let resultado = [...cubrimientoMinimal];

	for (let i = 0; i < cubrimientoMinimal.length; i++) {
		let dependencia = cubrimientoMinimal[i];
		let [izq, derecha] = dependencia.split(" -> ");

		let atributos = izq.split("");

		for (let j = 0; j < atributos.length; j++) {
			let sinAtr = atributos.filter((x, idx) => idx !== j);

			let temp = resultado.filter((dep) => dep !== dependencia);
			let clausura = devolverClausura(temp, sinAtr.join(""));
			//console.log(devolverClausura(temp, sinAtr.join("")));

			if (clausura.includes(derecha)) {
				resultado = resultado.filter((dep) => dep !== dependencia);

				const nuevaDep = `${sinAtr.join("")} -> ${derecha}`;

				if (!resultado.includes(nuevaDep)) {
					resultado.push(nuevaDep);
				}
				break;
			}
		}
	}
	return resultado;
};

const dependenciasTest = /*[
	"A -> BC",
	"B -> C",
	"A -> B",
	"AB -> D",
	"D -> E",
	"A -> E",
	"E -> F",
	"AF -> G",
];*/ ["ABC -> D", "A -> B", "A -> C"];
let cubrimientoMinimal = [];
cubrimientoMinimal = convertirFormatoEstandar(
	dependenciasTest,
	cubrimientoMinimal,
);
cubrimientoMinimal = verificarRedundancias(cubrimientoMinimal);
cubrimientoMinimal = resolverTransitivas(cubrimientoMinimal);
cubrimientoMinimal = eliminarDeterminantesAutodeterminantes(cubrimientoMinimal);

console.log(cubrimientoMinimal);

/*
const calcularCubrimientoMinimal = (dependencias) => {
	const cubrimientoMinimal = [];
	convertirFormatoEstandar(dependencias, cubrimientoMinimal);
	verificarRedundancias(cubrimientoMinimal);
	return cubrimientoMinimal;
};
*/
