const db = require("./models");

(async () => {
	try {
		await db.sequelize.authenticate();
		console.log("DB connection OK.");

		db.sequelize.sync({ alter: true }).then(() => {
			console.log("Base de datos conectada.");
		});
	} catch (error) {
		console.error(error);
	}
})();
