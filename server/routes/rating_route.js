const express = require("express");
const { getRating, postRating } = require("../controller/routing_controller");
const router = express.Router();

router.get("/:id", getRating);
router.post("/", postRating);
router.put("/", (req, res) => {});
router.delete("/", (req, res) => {});
module.exports = router;
