import {
	splitStringUsingForLoop,
	devolverClausura,
	iterarDependencias,
} from "./calculo-clausura-conjunto.js";

const eliminarDeterminantesAutodeterminantes = (cubrimientoMinimal) => {
	let resultado = [...cubrimientoMinimal];

	for (let i = 0; i < cubrimientoMinimal.length; i++) {
		let izq = cubrimientoMinimal[i].split(" -> ")[0];
		for (let j = 0; j < izq.length; j++) {
			let clausuraAtr = devolverClausura(cubrimientoMinimal, izq[j]);
			for (let h = 0; h < izq.length; h++) {
				let temp = [...izq];
				if (
					izq[h] != izq[j] &&
					clausuraAtr.includes(izq[h])
				) // Saco el atributo que el atributo determina
				{
					temp = temp.filter((atr) => atr != izq[h]).join("");
				}
			}
		}
		let nuevaDep = `${izq} -> ${cubrimientoMinimal[i].split(" -> ")[1]}`;
		resultado.push(nuevaDep);
		resultado = resultado.filter(
			(dep) => dep != `${izq} => ${cubrimientoMinimal[i].split(" -> ")[1]}`,
		);
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

let cubrimientoMinimal =
	eliminarDeterminantesAutodeterminantes(dependenciasTest);

console.log(cubrimientoMinimal);
