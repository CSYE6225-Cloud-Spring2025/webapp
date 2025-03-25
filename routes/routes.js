const express = require("express");
const multer = require("multer");
const healthCheckController = require("../controllers/healthCheckController");
const fileController = require("../controllers/fileController");
const fileUploadController = require("../controllers/fileUploadController");
const {infoLogger} = require("../logger");

const router = express.Router();
const upload = multer({
    storage: multer.memoryStorage(),
    limits: {fileSize: 500*1024*1024} // limit file size to 500 MB
});

router.all("/healthz", healthCheckController);

router.post("/v1/file", upload.single("file"), fileUploadController);
router.all("/v1/file/:id", fileController);

router.use((req, res) => {
    infoLogger.warn(`Invalid request to ${req.originalUrl}`);
    res.status(400).end();
});

module.exports = router;