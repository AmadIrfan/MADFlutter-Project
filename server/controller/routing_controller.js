const ratingModel = require("../models/rating_schema");
async function getRating(req, res) {
	try {
		const { id } = req.params;
		let rating = await ratingModel.find({ active: true, userId: id });
		res.status(200).send({ data: rating, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
async function postRating(req, res) {
	try {
		let rating = await ratingModel.create(req.body);
		res.status(200).send({ data: rating, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
module.exports = { getRating, postRating };
