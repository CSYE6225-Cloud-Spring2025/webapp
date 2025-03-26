const HealthCheck = require("../models/healthCheck");
const _ = require("lodash");
const {errorLogger, infoLogger} = require("../logger");
const statsd = require('../config/statsd');

const healthCheckController = async (req, res) => {
  infoLogger.info(`${req.method} method received for health check`);
  try {
    if (req.method != "GET") {
      infoLogger.warn(`${req.method} method is invalid for health check`);
      res.status(405).end();
    } 
    else if (!_.isEmpty(req.body) || !_.isEmpty(req.query)) {
      infoLogger.warn("Body or query parameters are not allowed for health check");
      res.status(400).end();
    } 
    else {
      const dbStartTime = Date.now();
      await HealthCheck.create({});
      statsd.timing('healthcheck.insert.time', Date.now() - dbStartTime);

      infoLogger.info("Health check record sucessful");
      res.status(200).end();
    }
  } catch (error) {
    errorLogger.error("Error during health check: ", error);
    res.status(503).end();
  }
};

module.exports = healthCheckController;
