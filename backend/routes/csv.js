const express = require("express");
const router = express.Router();
const multer = require('multer');
const csv = require('csv-parser');
const json2csv = require("json2csv").Parser;
const User = require("../models/usermodel");
const upload = multer();

router.get("/fetch", async (req, res) => {
  try {
    const documents = await User.find({});

    if (documents.length > 0) {
      const fieldMapping = {
        username: "Username",
        email: "Email",
        college: "College",
        branch: "Branch",
        phno: "Phone Number",
        city: "City",
        nop: "No of Pictures uploaded",
        isQuiz1Finished: "Quiz 1 Status",
        isQuiz2Finished: "Quiz 2 Status",
        isQuiz3Finished: "Quiz 3 Status",
        cs1: "Case Study 1",
        cs2: "Case Study 2",
        cs3: "Case Study 3",
        cs4: "Case Study 4",
        cs5: "Case Study 5"
      };

      // Transform the data using the fieldMapping
      const transformedData = documents.map(document => {
        const transformedDocument = {};
        for (const key in document._doc) {
          if (fieldMapping[key]) {
            // Check if the key corresponds to quiz status
            if (key === "isQuiz1Finished" || key === "isQuiz2Finished" || key === "isQuiz3Finished") {
              transformedDocument[fieldMapping[key]] = document._doc[key] ? "Finished" : "Not Finished";
            } else {
              transformedDocument[fieldMapping[key]] = document._doc[key];
            }
          }
        }
        return transformedDocument;
      });

      // Define the fields for CSV
      const fields = Object.values(fieldMapping);

      const json2csvParser = new json2csv({ fields });
      const csv = json2csvParser.parse(transformedData);

      res.setHeader("Content-Type", "text/csv");
      res.setHeader("Content-Disposition", "attachment; filename=output.csv");
      res.status(200).send(csv);
    }
  } catch (error) {
    console.log(error);
    res.status(401).send("Internal server error");
  }
});

router.post('/upload', upload.single('csvFile'),(req, res) => {
  try{
    const csvData = req.file.buffer.toString();
    console.log(csvData)
    if (!csvData) {
      return res.status(400).send('CSV data is required.');
  }
  
  const parser = csv({ headers: true });
  //console.log(parsedData)
    parser
        .on('data',async (data) => {
          console.log('Parsed data:', data);
          try {
            const email = data._0;
            const nop = parseInt(data._1);
            // Find the user in MongoDB based on the email
            const user = await User.findOne({ email });

            if (user) {
                // Update the NOP for the user
                user.nop = nop;
                await user.save(); // Save the updated user
                console.log(`Updated NOP for user ${email} to ${nop}`);
            } else {
                console.log(`User with email ${email} not found.`);
            }
        } catch (error) {
            console.error(`Error updating NOP for user ${email}: ${error}`);
        }
            
        });
        parser.on('end', () => {
          console.log('CSV data processed successfully.');
          res.send('CSV data processed successfully.');})

        const Readable = require('stream').Readable;
        const stream = new Readable();
        stream.push(csvData);
        stream.push(null);
        stream.pipe(parser);
  }
  catch(error){
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
  
});

module.exports = router;
