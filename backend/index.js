const express = require("express");
require("dotenv").config();
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const user = require("./routes/user");
const mongoose = require("mongoose");
const reset = require("./routes/reset");
const quiz = require("./routes/quiz");
const cert = require("./routes/cert");
const moduleRoute = require("./routes/module");
const app = express();
const cors = require("cors");
const helmet = require("helmet");
const morgan = require("morgan");
const csv = require("./routes/csv");

app.use(helmet());
app.use(cors());

//express middleware
app.use(express.json());

//moongose connection to database
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    //app listening to the requests
    app.listen(process.env.PORT, () => {
      console.log("listening to port " + process.env.PORT);
    });
  })
  .catch((error) => {
    console.log("error");
  });

app.use(morgan("combined"));

//route configuration for user login
app.use("/v1/api/user", user);

//route configuration for password reset
app.use("/v1/api/reset", reset);

//route configuration for quiz data
app.use("/v1/api/quiz", quiz);

//route configuration for certificate generation
app.use("/v1/api/certificate", cert);

app.use("/v1/api/module", moduleRoute);

app.use("/v1/api/csv", csv);

app.use("/test", (req, res) => {
  res.json({ message: "Hello from server" });
});
