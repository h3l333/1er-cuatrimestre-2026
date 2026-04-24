const potencia = (base, pot) => {
	if (pot == 0) return 1;
	else return base * potencia(base, pot - 1);
};

console.log(potencia(2, 5));
