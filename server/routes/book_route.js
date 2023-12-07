const express = require("express");
const router = express.Router();
const {
	getBooks,
	getBookByName,
	postBook,
	updateBook,
	continueStatusChange,
	changeActiveStatus,
	deleteBook,
	getBookData,
} = require("../controller/book_controller");



router.get("/", getBooks);
router.get("/bookData", getBookData);
router.get("/named/:id", getBookByName);
router.post("/", postBook);
router.put("/:id", updateBook);
router.put("/active/:id", changeActiveStatus);
router.put("/continue/:id", continueStatusChange);
router.delete("/", deleteBook);

module.exports = router;
