const nodemailer = require("nodemailer");
require("dotenv").config();
async function sendEmail(email, subject, text) {
	try {
		const transporter = nodemailer.createTransport({
			port: process.env.NODE_PORT,
			service: process.env.SERVICE,
			host: process.env.HOST,
			secure: true,
			auth: {
				user: process.env.EMAIL,
				pass: process.env.EMAIL_PASSWORD,
			},
		});
		await transporter.sendMail({
			from: `AMADIRFAN <${process.env.EMAIL}>`,
			to: email,
			subject: subject,
			html: `	<h3>${text}</h3>`,
		});
		return "email sent successfully";
	} catch (err) {
		return err.message;
	}
}
module.exports = {
	sendEmail,
};
