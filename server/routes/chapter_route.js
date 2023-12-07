const express = require("express");
const router = express.Router();
const {
	postChapter,
	getChapter,
	updateChapter,
} = require("../controller/chapter_controller");

router.post("/", postChapter);
router.get("/:id", getChapter);
router.put("/:id", updateChapter);
router.put("/", (req, res) => {});
router.delete("/", (req, res) => {});

module.exports = router;
