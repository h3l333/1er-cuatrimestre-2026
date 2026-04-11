let tablero = [
	[" ", " ", " ", " ", " ", " "],
	[" ", " ", " ", " ", "A", " "],
	[" ", " ", " ", " ", " ", " "],
	[" ", " ", "R", " ", " ", " "],
	[" ", " ", " ", " ", " ", " "],
	[" ", " ", " ", " ", " ", " "],
];

const encontrarRey = (tablero) => {
	for (let i = 0; i < tablero.length; i++) {
		for (let j = 0; j < tablero[i].length; j++) {
			if (tablero[i][j] === "R") return [i, j]; // Devuelvo coordenadas como vector
		}
	}
};

const encontrarAlfil = (tablero) => {
	for (let i = 0; i < tablero.length; i++) {
		for (let j = 0; j < tablero[i].length; j++) {
			if (tablero[i][j] === "A") return [i, j]; // Devuelvo coordenadas como vector
		}
	}
};

// La discrepancia entre iR e iA debe ser igual a aquella entre jR y jA. Podemos calcular el valor absoluto usando abs()
const estaEnJaque = (tablero) => {
	const posRey = encontrarRey(tablero);
	const posAlfil = encontrarAlfil(tablero);

	const discrepanciaIs = Math.abs(posRey[0] - posAlfil[0]);
	const discrepanciaJs = Math.abs(posRey[1] - posAlfil[1]);

	return discrepanciaIs === discrepanciaJs;
};

console.log(estaEnJaque(tablero));
