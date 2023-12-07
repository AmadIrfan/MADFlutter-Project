const mongoose = require("mongoose");

const chapters = new mongoose.Schema(
	{
		chapterName: { type: String, required: true },
		chapterNo: { type: Number, required: true },
		file: { type: String, required: true },
		bookId: { type: String, required: true },
		active: { type: Boolean, required: true, default: true },
		rating: {
			type: Array,
			required: true,
		},
	},
	{ timestamps: true }
);
const chapterModel = mongoose.model("Chapter", chapters);
module.exports = { chapterModel };
