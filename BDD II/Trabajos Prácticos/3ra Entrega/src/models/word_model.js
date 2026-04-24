// Este script no crea una tabla en nuestra base de datos directamente, sino que define la estructura que tendrá como una clase. La "mapea"

const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Word = sequelize.define(
	"Word",
	{
		word_id: {
			type: DataTypes.INTEGER,
			primaryKey: true,
			allowNull: false,
		},
		word: {
			type: DataTypes.STRING,
			allowNull: true,
		},
		reading: {
			type: DataTypes.STRING,
			allowNull: false,
		},
		starting_kana: {
			type: DataTypes.STRING,
			allowNull: false,
		},
	},
	{
		tableName: "word",
		indexes: [
			{
				name: "idx_starting_kana",
				fields: ["starting_kana"],
			},
		],
	},
);

module.exports = Word;
