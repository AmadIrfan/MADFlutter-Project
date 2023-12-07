const mongoose = require("mongoose");

const books = new mongoose.Schema(
	{
		name: { type: String, required: true, },
		publisher: { type: String, required: true },
		author: { type: String, required: true },
		category: { type: String, required: true, enum: ["novel", "comics"] },
		isContinue: { type: Boolean, required: true, default: true },
		active: { type: Boolean, required: true, default: true },
		Reader: { type: Array, required: true },
		Downloader: { type: Array, required: true },
		chapters: { type: Array, required: true },
		summery: { type: String, required: true },
		images: { type: Array, required: true },
		novel_rating: {
			type: Array,
			required: true,
		},
		availability: {
			type: Boolean,
			required: true,
			default: true,
		},
		iSBN: {
			type: String,
			required: true,
		},
		language: {
			type: String,
			required: true,
		},
		genre: {
			type: String,
			required: true,
		},
	},
	{ timestamps: true }
);
const bookModel = mongoose.model("books", books);
module.exports = { bookModel };
