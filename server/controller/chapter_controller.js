const { chapterModel } = require("../models/chapter_schema");
const { bookModel } = require("../models/book_schema");

async function postChapter(req, res) {
	try {
		const { bookId } = req.body;
		let chp = await chapterModel.create(req.body);
		let book = await bookModel.findByIdAndUpdate(
			bookId,
			{ $push: { chapters: chp.id } },
			{ new: true }
		);

		res.status(201).send({ data: chp, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function getChapter(req, res) {
	try {
		const { active } = req.query;
		const { id } = req.params;
		let query = {};
		if (active !== undefined) {
			query.active = active === "true";
		}
		var bookArray = [];
		let book = await chapterModel.find({ bookId: id });
		// await Promise.all(
		// 	book.chapters.map(async (e) => {
		// 		var chp = await chapterModel.findById(e);
		// 		bookArray.push(chp);
		// 	})
		// );
		res.status(200).send({ data: book, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}

async function updateChapter(req, res) {
	try {
		const { id } = req.params;
		const { active } = req.body;
		console.log(req.body);
		const book = await chapterModel.findByIdAndUpdate(id, req.body);
		console.log(book);
		res.status(200).send({ data: book, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}

module.exports = {
	postChapter,
	getChapter,
	updateChapter,
};
