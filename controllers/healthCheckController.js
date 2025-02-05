const HealthCheck = require("../models/healthCheck");
const _ = require("lodash");

const insertHealthCheck = async (req, res) => {
  try {
    if (!_.isEmpty(req.body) || !_.isEmpty(req.query)) {
      res.status(400).end()
    } else {
      await HealthCheck.create({});
      res.status(200).end();
    }
  } catch (error) {
    console.log("Error during insert: " + error);
    res.status(503).end()
  }
};

module.exports = insertHealthCheck;
