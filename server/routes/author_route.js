const express = require("express");
const router = express.Router();
const {
	deleteAuthor,
	updateAuthor,
	activateAuthor,
	getAuthor,
	registerAuthor,
} = require("../controller/author_controller");

router.get("/", getAuthor);
router.post("/", registerAuthor);
router.put("/active/:userId", activateAuthor);
router.put("/:id", updateAuthor);
router.delete("/:id", deleteAuthor);
module.exports = router;
