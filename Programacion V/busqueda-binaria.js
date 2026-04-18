let nro = 700;
let lastGuess = 1;
let ceil;
let floor;

function buscBin(nro, lastGuess, floor, ceil) {
	if (nro === lastGuess) {
		return lastGuess;
	} else if (nro > lastGuess) {
		return buscBin(nro, lastGuess * 2);
	}
	return buscBin(nro, lastGuess / 2);
}

console.log(buscBin(nro, lastGuess));
