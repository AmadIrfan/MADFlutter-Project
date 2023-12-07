const mongoose = require("mongoose");

const rating = new mongoose.Schema(
	{
		userId: {
			type: String,
			required: true,},
		novelId: { type: String, required: true },
		feedback: {
			type: String,
			required: true,
		},
		Rating: {
			type: Number,
			required: true,
		},
		active: {
			type: Boolean,
			required: true,
			default: true,
		},
	},
	{ timestamps: true }
);

const ratingModel = mongoose.model("rating", rating);

module.exports = ratingModel;
