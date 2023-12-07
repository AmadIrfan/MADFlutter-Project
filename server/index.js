var express = require("express");
var path = require("path");
const cors = require("cors");
var logger = require("morgan");
const db = require("./utils/db/mongoDB");
var createError = require("http-errors");
const morgan = require("morgan");
var cookieParser = require("cookie-parser");
require("dotenv").config();
const authorRoute = require("./routes/author_route");
const bookRoute = require("./routes/book_route");
const chapterRoute = require("./routes/chapter_route");
const bookRating = require("./routes/rating_route");
var app = express();
var email =require('./routes/email_rout')
app.use(cors());

app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));
app.use("/author", authorRoute);
app.use("/book", bookRoute);
app.use("/chapter", chapterRoute);
app.use("/rating", bookRating);
app.use("/email", email);

app.get("/", (req, res) => {
	res.send("this is server");
});

app.listen(process.env.PORT, () => {
	console.log("server is running");
});
