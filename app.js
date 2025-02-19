const express = require("express");
const sequelize = require("./config/database");
const healthCheckRoutes = require("./routes/healthCheckRoutes");

const app = express();
app.use((req, res, next) => {
  res.setHeader("Cache-Control", "no-cache");
  if (req.method != "GET") {
    res.status(405).end()
  }
  next();
});
app.use(express.json());
app.use("/", healthCheckRoutes);

sequelize.sync().then(() => {
    console.log("Database sync successful");
  }).catch((error) => {
    console.error("Database sync failed: ", error);
  });

module.exports = {app, sequelize};