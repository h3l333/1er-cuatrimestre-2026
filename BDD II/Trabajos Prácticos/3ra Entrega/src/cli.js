const readline = require("node:readline/promises");
const { stdin: input, stdout: output } = require("node:process");

const { addEntry, getEntries } = require("./services/dict_entry_service");
const { addWord, getWords } = require("./services/word_service");

const rl = readline.createInterface({ input, output });

const menu = async () => {
	let option = await rl.question(
		"Qué acción desea realizar?\n1) Registrar una palabra\n2) Registrar una entrada de diccionario\n3) Consultar las palabras guardadas\n4) Consultar las entradas guardadas\n",
	);
	await menuOptions(option);
};

const menuOptions = async (option) => {
	switch (option) {
		case "1": {
			console.log("Por favor escribe los datos asociados a la palabra:");
			let wordId = await rl.question("ID de la palabra:\n");
			let word = await rl.question("Palabra:\n");
			let kanaReading = await rl.question(
				"Esctritura en kana de la palabra:\n",
			);
			let startingKana = await rl.question("Kana inicial:\n");
			const wordObject = {
				word_id: wordId,
				word: word,
				reading: kanaReading,
				starting_kana: startingKana,
			};
			try {
				await addWord(wordObject);
				console.log("Palabra registrada con éxito.");
			} catch (error) {
				console.error(
					"Hubo un error al insertar la palabra en la BDD...\n",
					error,
				);
			}
			menu();
			break;
		}
		case "2": {
			console.log(
				"Por favor escribe los datos asociados a la entrada de diccionario:",
			);
			let entryId = await rl.question("ID de la entrada:\n");
			let entryLink = await rl.question("Link:\n");
			let source = await rl.question("Fuente:\n");
			let wordId = await rl.question("ID de la palabra asociada:\n");
			const entryObject = {
				entry_id: entryId,
				link: entryLink,
				source: source,
				word_id: wordId,
			};
			try {
				await addEntry(entryObject);
				console.log("Entrada registrada con éxito.");
			} catch (error) {
				console.error("Hubo un error al insertar la palabra en la BDD...\n");
				if (error.parent?.errno === 1452)
					console.log(`No hay una palabra existente con el id ${wordId}.`);
			}
			menu();
			break;
		}
		case "3": {
			try {
				const words = await getWords();
				words.forEach((w) => {
					console.log(w.toJSON());
				});
			} catch (error) {
				console.error(
					"Hubo un error al buscar las palabras de la BDD...\n",
					error,
				);
			}
			menu();
			break;
		}
		case "4": {
			try {
				const entries = await getEntries();
				entries.forEach((ent) => {
					console.log(ent.toJSON());
				});
			} catch (error) {
				console.error(
					"Hubo un error al buscar las entradas de la BDD...\n",
					error,
				);
			}
			menu();
			break;
		}
		case "0": {
			process.exit(0);
			break;
		}
		default:
			console.log("Opción invalida. Vuelva a intentar.\n");
	}
};

menu();
