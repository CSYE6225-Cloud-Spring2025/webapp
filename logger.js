const log4js = require("log4js");

log4js.configure({
  appenders: {
    errorLogs: {type:"file", filename:"/var/log/nodejs/webapp-error.log", maxLogSize:10485760, backups:3, compress:false, 
      layout: {
        type: "pattern",
        pattern: '{"timestamp":"%d{ISO8601}","level":"%p","category":"%c","message":"%m","error":"%j"}'
      }
    },
    infoLogs: {type:"file", filename:"/var/log/nodejs/webapp-info.log", maxLogSize:10485760, backups:3, compress:false, 
      layout: {
        type: "pattern",
        pattern: '{"timestamp":"%d{ISO8601}","level":"%p","category":"%c","message":"%m"}'
      }
    }
  },
  categories: {
    error: {appenders:["errorLogs"], level:"error"},
    default: {appenders:["infoLogs"], level: "info"}
  }
});

const errorLogger = log4js.getLogger("error");
const infoLogger = log4js.getLogger();

module.exports = {errorLogger, infoLogger};
