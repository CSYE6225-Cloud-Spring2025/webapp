const express = require("express");
const sequelize = require("./config/database");
const routes = require("./routes/routes");
const {errorLogger, infoLogger} = require("./logger");

const app = express();
app.use((_req, res, next) => {
  res.setHeader("Cache-Control", "no-cache");
  next();
});
app.use(express.json());
app.use("/", routes);

sequelize.sync().then(() => {
    infoLogger.info("Database sync successful");
  }).catch((error) => {
    errorLogger.error("Database sync failed: ", error);
  });

module.exports = {app, sequelize};