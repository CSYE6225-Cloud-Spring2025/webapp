const express = require("express");
const insertHealthCheck = require("../controllers/healthCheckController");

const router = express.Router();

router.get("/healthz", insertHealthCheck);

module.exports = router;