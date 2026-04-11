const nroParaAdivinar = 100;
let nroInicial = 1;
// Cuando lo adivina devuelve el nro.
const adivinar = (nroParaAdivinar, nroInicial) => {
	let nro = nroInicial;
	let cantIntentos = 1;
	while (nro < nroParaAdivinar) {
		nro = nro * 2;
		cantIntentos++;
	}
	let base = nro / 2; // Se seguro que es mas grande que la base
	let alto = nro;
	while (nro !== nroParaAdivinar) {
		nro = Math.floor(base + (alto - base) / 2);
		cantIntentos++;
		if (nroParaAdivinar < nro) {
			// Si es mas chico, actualizo el alto
			// console.log("Alto antes: ", alto);
			alto = nro;
			// console.log("Alto despues: ", alto);
		} else {
			// En caso contrario, actualizo la base
			// console.log("Base antes: ", base);
			base = nro;
			// console.log("Base despues: ", base);
		}
	}
	return [nro, cantIntentos];
};

const [numero, intentos] = adivinar(nroParaAdivinar, nroInicial);

console.log("Adivine el nro. ", numero, " en ", intentos, " intentos.");
