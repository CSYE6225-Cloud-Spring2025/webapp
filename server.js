const {app, _} = require("./app");
const {infoLogger} = require("./logger");

const port = process.env.PORT || 3000;
app.listen(port, () => {
  infoLogger.info("Server started on port: " + port);
});