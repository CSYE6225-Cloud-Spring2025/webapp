const StatsD = require('hot-shots');
const {errorLogger} = require('../logger');

const statsd = new StatsD({
  host: "localhost",
  port: 8125,
  errorHandler: (error) => {
    errorLogger.error("StatsD error: ", error)
  }
});

module.exports = statsd;