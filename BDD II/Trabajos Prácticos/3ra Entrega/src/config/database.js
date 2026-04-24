const { Sequelize } = require("sequelize");
const path = require("path");
const envPath = path.resolve(__dirname, "../../.env");

require("dotenv").config({ path: envPath });

const sequelize = new Sequelize(
	process.env.DB_NAME,
	process.env.DB_USER,
	process.env.DB_PASS,
	{
		host: process.env.DB_HOST,
		dialect: "mysql",
		timestamps: true,
		define: {
			charset: "utf8mb4",
		},
	},
);

module.exports = sequelize;
