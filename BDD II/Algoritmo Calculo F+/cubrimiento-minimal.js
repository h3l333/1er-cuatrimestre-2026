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
	});
	return cubrimientoMinimal;
};

const resolverTransitivas = (dependencias) => {
	let resultado = [...dependencias];

	for (let i = 0; i < dependencias.length; i++) {
		let dependencia = dependencias[i];
		let izq = dependencia.split(" -> ")[0];
		let der = dependencia.split(" -> ")[1];

		// Ver que atributos determina el lado derecho
		let temp = resultado.filter((dep) => dep !== dependencia);
		let clausura = devolverClausura(temp, izq);
		for (let j = 0; j < temp.length; j++) {
			if (dependencias.includes(`${izq} -> ${clausura[j]}`)) {
				resultado = resultado.filter(
					(dep) => dep !== `${izq} -> ${clausura[j]}`,
				);
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

const dependenciasTest = [
	"A -> BC",
	"B -> D",
	"CD -> E",
	"E -> F",
	"AF -> D",
	"C -> A",
	"A -> D",
];
let cubrimientoMinimal = [];
cubrimientoMinimal = resolverTransitivas(
	verificarRedundancias(
		convertirFormatoEstandar(dependenciasTest, cubrimientoMinimal),
	),
);

console.log(cubrimientoMinimal);

/*
const calcularCubrimientoMinimal = (dependencias) => {
	const cubrimientoMinimal = [];
	convertirFormatoEstandar(dependencias, cubrimientoMinimal);
	verificarRedundancias(cubrimientoMinimal);
	return cubrimientoMinimal;
};
*/
