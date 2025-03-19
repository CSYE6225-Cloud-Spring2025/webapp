const express = require("express");
const sequelize = require("./config/database");
const routes = require("./routes/routes");

const app = express();
app.use((_req, res, next) => {
  res.setHeader("Cache-Control", "no-cache");
  next();
});
app.use(express.json());
app.use("/", routes);

sequelize.sync().then(() => {
    console.log("Database sync successful");
  }).catch((error) => {
    console.error("Database sync failed: ", error);
  });

module.exports = {app, sequelize};