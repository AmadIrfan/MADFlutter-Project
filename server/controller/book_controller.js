const { bookModel } = require("../models/book_schema");
async function getBooks(req, res) {
	try {
		const { active } = req.query;
		let query = {};
		if (active !== undefined) {
			query.active = active === "true";
		}
		let book = await bookModel.find(query);
		res.status(200).send({ data: book, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function getBookByName(req, res) {
	try {
		let { id } = req.params;
		const { active } = req.query;
		let query = {};

		if (active !== undefined) {
			query.active = active === "true";
		}
		let book = await bookModel.find({ publisher: id }).where(query);
		res.status(200).send({ data: book, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function postBook(req, res) {
	try {
		let addBook = await bookModel.create(req.body);
		res
			.status(201)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}

async function updateBook(req, res) {
	try {
		const { id } = req.params;
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res
			.status(200)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function changeActiveStatus(req, res) {
	try {
		const { id } = req.params;
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res
			.status(200)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function continueStatusChange(req, res) {
	try {
		const { id } = req.params;
		let addBook = await bookModel.findByIdAndUpdate(id, req.body);
		res
			.status(200)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function deleteBook(req, res) {
	try {
		const { id } = req.params;
		let addBook = await bookModel.findByIdAndRemove(id);
		res
			.status(200)
			.send({ data: addBook, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function getBookData(req, res) {
	try {
		let data = {};
		let active = 0;
		let inActive = 0;
		let book = await bookModel.find();
		book.forEach((element) => {
			if (element.active) {
				active++;
				data["active"] = active;
			} else {
				inActive++;
				data["inactive"] = inActive;
			}
		});
		data["total"] = book.length;
		console.log(data);
		res.status(200).send({ data: data, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
module.exports = {
	getBooks,
	getBookByName,
	postBook,
	updateBook,
	changeActiveStatus,
	continueStatusChange,
	deleteBook,
	getBookData,
};

// router.get("/done", async (req, res) => {
// 	try {
// 		for (let i = 1; i <= 30; i++) {
// 			const dummyBook = {
// 				name: `Book ${i}`,
// 				publisher: `Publisher ${(i % 5) + 1}`,
// 				author: `Author ${(i % 7) + 1}`,
// 				category: i % 2 === 0 ? "novel" : "comics",
// 				isContinue: i % 2 === 0,
// 				active: i % 3 === 0,
// 				Reader: [`Reader${(i % 3) + 1}`, `Reader${(i % 3) + 2}`],
// 				Downloader: [`Downloader${(i % 3) + 1}`, `Downloader${(i % 3) + 2}`],
// 				chapters: [`Chapter${(i % 5) + 1}`, `Chapter${(i % 5) + 2}`],
// 				summery: `Summary ${i}`,
// 				images: [`https://picsum.photos/200/300?random=${i + 1}`, `https://picsum.photos/200/300?random=${i + 10}`],
// 				novel_rating: [
// 					Math.floor(Math.random() * 5) + 1,
// 					Math.floor(Math.random() * 5) + 1,
// 				],
// 				availability: i % 4 === 0,
// 				iSBN: `ISBN-${(i % 3) + 1}-${(i % 4) + 1}`,
// 				language: i % 2 === 0 ? "English" : "Spanish",
// 				genre: i % 3 === 0 ? "Fiction" : "Non-Fiction",
// 			};
// 			await bookModel.create(dummyBook);
// 			console.log(i);
// 		}
// 		res.status(200).send({ data: [], message: "Successful", status: "ok" });
// 	} catch (e) {
// 		res.status(505).send({ data: null, message: e.message, status: "error" });
// 	}
// });
