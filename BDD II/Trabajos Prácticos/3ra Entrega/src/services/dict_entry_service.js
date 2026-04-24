const { DictEntry } = require("../models");

async function addEntry(entryData) {
	return await DictEntry.create(entryData);
}

async function getEntries() {
	return await DictEntry.findAll();
}

module.exports = { addEntry, getEntries };
