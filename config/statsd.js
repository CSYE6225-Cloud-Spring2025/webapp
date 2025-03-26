const StatsD = require('hot-shots');
const {errorLogger} = require('../logger');

const statsd = new StatsD({
  host: "localhost",
  port: 8125,
  prefix: "nodejs_webapp.",
  errorHandler: (error) => {
    errorLogger.error("StatsD error: ", error)
  }
});

module.exports = statsd;