const sequelize = require("../config/database");
const Word = require("./word_model.js");
const DictEntry = require("./dict_entry_model.js");

const db = {
	sequelize,
	Word,
	DictEntry,
};

// Asociación
db.DictEntry.belongsTo(db.Word, {
	foreignKey: "word_id",
});

db.Word.hasMany(db.DictEntry, {
	foreignKey: "word_id",
});

module.exports = db;
