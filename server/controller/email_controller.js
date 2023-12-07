const { sendEmail } = require("../utils/email");
const { emailModel } = require("../models/email_schema");
async function emailSending(req, res) {
	try {
		const { email, subject, body } = req.body;
		let result = await sendEmail(email, subject, body);
		let saveEmail = await emailModel.create(req.body);
		res.status(200).send({ data: result, message: "Successful", status: "ok" });
	} catch (e) {
		res.status(505).send({ data: null, message: e.message, status: "error" });
	}
}
module.exports = { emailSending };
