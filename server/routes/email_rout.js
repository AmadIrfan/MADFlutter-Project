const express = require("express");
const { emailSending } = require("../controller/email_controller");
const router = express.Router();

router.post("/", emailSending);
module.exports = router;
