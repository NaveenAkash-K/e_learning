const express = require("express");
const router = express.Router();
const nodemailer = require("nodemailer");
const speakeasy = require("speakeasy");
const bcrypt = require("bcrypt");
const User = require("../models/usermodel");

const transporter = nodemailer.createTransport({
  service: "Outlook365",

  host: "smtp.office365.com",
  port: "587",
  tls: {
    ciphers: "SSLv3",
    rejectUnauthorized: false,

  },
  auth: {
    user: process.env.EMAIL,
    pass: process.env.PASSWD,
  },
});

router.post("/forgot-password", async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (!user.otpSecret) {
      // Generate and save OTP secret
      const otpSecret = speakeasy.generateSecret().base32;
      user.otpSecret = otpSecret;
      await user.save();
    }
    // Generate OTP
    const otp = speakeasy.totp({
      secret: user.otpSecret,
      encoding: "base32",
    });
    

    const mailOptions = {
      from: process.env.EMAIL,
      to: user.email,
      subject: "Password Reset OTP",
      text: `Your OTP for password reset is: ${otp}`,
    };

    await transporter.sendMail(mailOptions);

    res.json({ message: "OTP sent successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.post("/verify-otp", async (req, res) => {
  try {
    const { email, otp } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (!user.otpSecret) {
      return res.status(400).json({ message: "OTP secret not found" });
    }

    const isValidOTP = speakeasy.totp.verify({
      secret: user.otpSecret,
      encoding: "base32",
      token: otp,
      window: 6,
    });

    if (!isValidOTP) {
      return res.status(401).json({ message: "Invalid OTP" });
    }

    res.json({ message: "OTP verified successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

router.post("/reset-password", async (req, res) => {
  try {
    const { email, otp, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    if (!user.otpSecret) {
      return res.status(400).json({ message: "OTP secret not found" });
    }

    const isValidOTP = speakeasy.totp.verify({
      secret: user.otpSecret,
      encoding: "base32",
      token: otp,
      window: 6,
    });
    if (!isValidOTP) {
      console.log(otp);
      console.log(user.otpSecret);
      return res.status(401).json({ message: "Invalid OTP" });
    }

    // Update password and clear OTP secret
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);
    user.password = hashedPassword;
    user.otpSecret = undefined;
    await user.save();

   

    res.json({ message: "Password reset successful" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});
module.exports = router;
