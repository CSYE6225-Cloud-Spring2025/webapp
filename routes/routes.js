const express = require("express");
const multer = require("multer");
const healthCheckController = require("../controllers/healthCheckController");
const fileController = require("../controllers/fileController");
const fileUploadController = require("../controllers/fileUploadController");
const {infoLogger} = require("../logger");
const statsd = require('../config/statsd');

const router = express.Router();
const upload = multer({
    storage: multer.memoryStorage(),
    limits: {fileSize: 500*1024*1024} // limit file size to 500 MB
});

router.use((req, res, next) => {
    statsd.increment(`api.calls.${req.method} ${req.baseUrl}`);

    const originalEnd = res.end;
    const startTime = Date.now();
    res.end = function(...args) {
        const endTime = Date.now() - startTime;
        statsd.timing(`api.response_time.${req.method} ${req.baseUrl}`, endTime);
        return originalEnd.apply(this, args);
    };
    next();
});

router.all("/healthz", healthCheckController);
router.post("/v1/file", upload.single("file"), fileUploadController);
router.all("/v1/file/:id", fileController);

router.use((req, res) => {
    infoLogger.warn(`Invalid request to ${req.originalUrl}`);
    res.status(400).end();
});

module.exports = router;