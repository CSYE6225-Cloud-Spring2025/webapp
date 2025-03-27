const log4js = require("log4js");

log4js.addLayout("json", () => (logEvent) => {
  const logJSON = {
    timestamp: logEvent.startTime.toISOString(),
    level: logEvent.level.levelStr,
    category: logEvent.categoryName,
    message: logEvent.data[0]
  };
  if (logEvent.data[1] instanceof Error) {
    logJSON.error = {
      message: logEvent.data[1].message,
      stack: logEvent.data[1].stack
    };
  }
  return JSON.stringify(logJSON);
});

log4js.configure({
  appenders: {
    errorLogs: {type:"file", filename:"/var/log/nodejs/webapp-error.log", maxLogSize:10485760, backups:3, compress:false, 
      layout: {
        type: "json",
      }
    },
    infoLogs: {type:"file", filename:"/var/log/nodejs/webapp-info.log", maxLogSize:10485760, backups:3, compress:false, 
      layout: {
        type: "json",
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
