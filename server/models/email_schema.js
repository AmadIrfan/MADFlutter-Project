const mongoose = require("mongoose");

const books = new mongoose.Schema(
	{
		email: { type: String, required: true },
		body: { type: String, required: true },
		subject: { type: String, required: true },
	},
	{ timestamps: true }
);
const emailModel = mongoose.model("email", books);
module.exports = { emailModel };
