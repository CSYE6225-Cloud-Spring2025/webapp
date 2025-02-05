const express = require("express");
const insertHealthCheck = require("../controllers/healthCheckController");

const router = express.Router();

router.get("/healthz", insertHealthCheck);
router.use((_req, res) => {
    res.status(400).end()
});

module.exports = router;