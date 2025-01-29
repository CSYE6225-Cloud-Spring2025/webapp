require("dotenv").config({ path: "./database.env" });
const {Sequelize} = require("sequelize");

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_HOST,
  dialect: "mysql",
});

sequelize.authenticate().then(() => {
    console.log("Connection is successful");
  }).catch((error) => {
    console.error("Connection failed: ", error);
  });

module.exports = sequelize;