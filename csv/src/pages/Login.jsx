// Login.jsx

import React, { useState, useEffect } from "react";
import axios from "axios";
import styles from "../styles/pages/login.module.css"; // Import your CSS module
import { useNavigate } from "react-router-dom";

function Login() {
  const [email, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [loginInvalid, setLoginInvalid] = useState(false);

  useEffect(() => {
    if (localStorage.getItem("token") !== null) {
      navigate("/upload");
    }
  }, []);

  const navigate = useNavigate();

  const handleUsernameChange = (event) => {
    setUsername(event.target.value);
  };

  const handlePasswordChange = (event) => {
    setPassword(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      const response = await axios.post(
        "https://e-learning-gray.vercel.app/v1/api/csv/adminLogin",
        {
          email,
          password,
        }
      );

      const token = response.data.token;

      localStorage.setItem("token", token);
      navigate("/upload");
    } catch (error) {
      setLoginInvalid(true);
    }
  };

  return (
    <div className={styles.container}>
      <div className={styles.form_container}>
        <form onSubmit={handleSubmit}>
          <h2 className={styles.form_title}>Login</h2>
          <div>
            <label htmlFor="username">Username</label>
            <input
              type="text"
              id="username"
              name="username"
              value={email}
              onChange={handleUsernameChange}
              className={styles.form_input}
            />
          </div>
          <div>
            <label htmlFor="password">Password</label>
            <input
              type="password"
              id="password"
              name="password"
              value={password}
              onChange={handlePasswordChange}
              className={styles.form_input}
            />
          </div>
          {loginInvalid && <p style={{ color: "red" }}>Invalid Credentials</p>}

          <div>
            <button type="submit" className={styles.form_button}>
              Login
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default Login;
