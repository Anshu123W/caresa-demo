import bcrypt from 'bcrypt';
import { pool } from '../db.js';

export const signupNormalUser = async (req, res) => {
  console.log('📩 BODY RECEIVED:', req.body);

  const { fullName, email, password } = req.body;

  if (!fullName || !email || !password) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `INSERT INTO normal_users (full_name, email, password_hash)
       VALUES ($1, $2, $3)
       RETURNING id, email`,
      [fullName, email, hashedPassword]
    );

    console.log('✅ INSERTED:', result.rows[0]);

    res.status(201).json({
      message: 'Normal user created',
      user: result.rows[0],
    });
  } catch (err) {
    console.error('❌ DB ERROR:', err.message);
    res.status(500).json({ error: err.message });
  }
};
