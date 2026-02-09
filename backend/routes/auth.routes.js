import express from 'express';
import bcrypt from 'bcrypt';
import { pool } from '../db.js';

const router = express.Router();

router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // ===============================
    // HR LOGIN
    // ===============================
    if (email === "hr@company.com" && password === "123456") {
      return res.json({ role: "hr" });
    }

    // ===============================
    // ORGANISATION USER LOGIN (FIRST)
    // ===============================
    const orgResult = await pool.query(
      "SELECT * FROM organisation_users WHERE email = $1",
      [email]
    );

    if (orgResult.rows.length > 0) {
      const user = orgResult.rows[0];
      const isMatch = await bcrypt.compare(
        password,
        user.password_hash
      );

      if (isMatch) {
        return res.json({
          role: "organisation_user",
          userId: user.id
        });
      }
    }

    // ===============================
    // NORMAL USER LOGIN
    // ===============================
    const normalResult = await pool.query(
      "SELECT * FROM normal_users WHERE email = $1",
      [email]
    );

    if (normalResult.rows.length > 0) {
      const user = normalResult.rows[0];
      const isMatch = await bcrypt.compare(
        password,
        user.password_hash
      );

      if (isMatch) {
        return res.json({
          role: "normal_user",
          userId: user.id
        });
      }
    }

    // ===============================
    // INVALID LOGIN
    // ===============================
    return res.status(401).json({
      error: "Invalid credentials"
    });

  } catch (err) {
    console.error("Login error:", err);
    res.status(500).json({ error: "Server error" });
  }
});

// 🔴 THIS LINE FIXES YOUR ERROR
export default router;
