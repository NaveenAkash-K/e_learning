// Upload.jsx

import React, { useState, useEffect } from "react";
import axios from "axios";
import styles from "../styles/pages/upload.module.css"; // Import your CSS module
import { useNavigate } from "react-router-dom";

const Upload = () => {
  const [file, setFile] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    if (localStorage.getItem("token") === null) {
      navigate("/");
    }
  }, []);

  const handleLogout = () => {
    localStorage.clear();
    navigate("/");
  };

  const handleFileChange = (event) => {
    setFile(event.target.files[0]);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      if (!file) {
        console.error("No file selected");
        return;
      }

      const formData = new FormData();
      formData.append("csvFile", file); // Match the field name expected by the server

      await axios.post(
        "https://e-learning-gray.vercel.app/v1/api/csv/upload",
        formData,
        {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        }
      );

      alert("Upload success");
    } catch (error) {
      console.error("Upload failed:", error);
    }
  };

  return (
    <div className={styles.container}>
      <div className={styles.formContainer}>
        <form onSubmit={handleSubmit}>
          <h1 className={styles.formTitle}>Upload a CSV File</h1>
          <h3 className={styles.formSubtitle}>
            Please select a CSV file (Excel files with extension .xls are not
            supported).
          </h3>

          <input
            type="file"
            id="csvData"
            accept=".csv"
            onChange={handleFileChange}
            className={styles.fileInput}
          />
          <br />
          <br />
          <button type="submit" className={styles.uploadButton}>
            Upload
          </button>
        </form>

        <br />
        <button onClick={handleLogout} className={styles.logoutButton}>
          Logout
        </button>
      </div>
    </div>
  );
};

export default Upload;
