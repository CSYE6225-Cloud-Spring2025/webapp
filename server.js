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

const port = process.env.PORT || 3000;
sequelize.sync().then(() => {
    console.log("Database sync successful");
    app.listen(port, () => {
      console.log("Server started on http://localhost:"+port);
    });
  }).catch((error) => {
    console.error("Database sync failed: ", error);
  });