const express = require("express");
const sequelize = require("./config/database");
const healthCheckRoutes = require("./routes/healthCheckRoutes");

const app = express();
app.use((req, res, next) => {
  res.setHeader("Cache-Control", "no-cache");
  if (req.method != "GET") {
    res.sendStatus(405);
  }
  next();
});
app.use(express.json());
app.use("/", healthCheckRoutes);

sequelize.sync().then(() => {
    console.log("Database sync successful");
    app.listen(8080, () => {
      console.log("Server started on http://localhost:8080");
    });
  }).catch((error) => {
    console.error("Database sync failed: ", error);
  });