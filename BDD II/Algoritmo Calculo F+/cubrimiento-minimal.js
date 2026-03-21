import {
	splitStringUsingForLoop,
	devolverClausura,
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

const verificarRedundancias = (cubrimientoMinimal) => {
	cubrimientoMinimal.forEach((dependencia) => {
		// Para cada atributo a la izquierda analizar si es redundante. Si lo es, sacarlo
		const atributosDependenciaIzq = splitStringUsingForLoop(
			dependencia.split(" -> ")[0],
			1,
		);
		for (let i = 0; i < atributosDependenciaIzq.length; i++) {
			let determinantesSinAtr = atributosDependenciaIzq.filter(
				(atr) => atr !== atributosDependenciaIzq[i],
			);
			if (
				devolverClausura(dependencias, determinantesSinAtr).includes(
					devolverClausura(dependencias, atributosDependenciaIzq),
				)
			) {
				cubrimientoMinimal = cubrimientoMinimal.filter(dependencia);
				cubrimientoMinimal.push(
					`${determinantesSinAtr} -> ${dependencia.split(" -> ")[1]}`,
				);
			}
		}
	});
	return cubrimientoMinimal;
};

const dependenciasTest = ["X -> ABC"];
let cubrimientoMinimal = [];
cubrimientoMinimal = verificarRedundancias(
	convertirFormatoEstandar(dependenciasTest, cubrimientoMinimal),
);

/*
const calcularCubrimientoMinimal = (dependencias) => {
	const cubrimientoMinimal = [];
	convertirFormatoEstandar(dependencias, cubrimientoMinimal);
	verificarRedundancias(cubrimientoMinimal);
	return cubrimientoMinimal;
};
*/
