const { Word } = require("../models");

// Receives a plain JavaScript object that contains key-value pairs matching defined columns
async function addWord(wordData) {
	return await Word.create(wordData);
}

async function getWords() {
	return await Word.findAll();
}

module.exports = { addWord, getWords };
