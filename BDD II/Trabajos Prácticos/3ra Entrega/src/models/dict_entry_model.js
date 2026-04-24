const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const DictEntry = sequelize.define("DictEntry", {
	entry_id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		allowNull: false,
	},
	link: {
		type: DataTypes.STRING,
		allowNull: false,
	},
	source: {
		type: DataTypes.STRING,
	},
});

module.exports = DictEntry;
