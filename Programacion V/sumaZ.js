let suma = 1;
let ultimoNumerador = 1;
let ultimoDenominador = 1;

function calcularZ(n, x) {
	for (let i = 1; i <= n; i++) {
		suma += (ultimoNumerador * i) / (ultimoDenominador * x);
		ultimoNumerador *= i;
		ultimoDenominador *= x;
	}
	return suma;
}

console.log(calcularZ(4, 10));
