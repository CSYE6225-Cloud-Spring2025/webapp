const HealthCheck = require("../models/healthCheck");
const _ = require("lodash");

const insertHealthCheck = async (req, res) => {
  try {
    if (!_.isEmpty(req.body)) {
      res.sendStatus(400);
    } else {
      await HealthCheck.create({});
      res.sendStatus(200);
    }
  } catch (error) {
    console.log("Error during insert: " + error);
    res.sendStatus(503);
  }
};

module.exports = insertHealthCheck;
