import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import sql from './dbconn.js';
import { pool } from './db.js';

import normalUserRoutes from './routes/normalUser.routes.js';
import organisationUserRoutes from './routes/organisationUser.routes.js';
import authRoutes from './routes/auth.routes.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// ===============================
// MIDDLEWARE
// ===============================
app.use(cors());
app.use(express.json());

// Request logger
app.use((req, res, next) => {
  console.log(`➡️ ${req.method} ${req.url}`);
  next();
});

// ===============================
// BASIC ROUTES (from File 1)
// ===============================
app.get("/", (req, res) => {
  res.send('Port is running!');
});

app.post('/get-user-id', async (req, res) => {
  try {
    const { firebaseUid } = req.body;

    if (!firebaseUid) {
      return res.status(400).json({ error: 'Firebase UID is required!' });
    }

    const result = await sql`
      SELECT user_id FROM users_ WHERE firebase_uid = ${firebaseUid}
    `;

    if (result.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    res.json({ userId: result[0].user_id });

  } catch (err) {
    console.log(err);
    res.status(500).json({ error: "Database Error", details: err.message });
  }
});

app.post("/responses", async (req, res) => {
  try {
    const { userId, questionIds, answers } = req.body;

    if (!userId || !questionIds || !answers) {
      return res.status(400).json({ error: "Missing fields" });
    }
    if (!Array.isArray(questionIds) || !Array.isArray(answers)) {
      return res.status(400).json({ error: "questionIds and answers must be arrays" });
    }
    if (questionIds.length !== answers.length) {
      return res.status(400).json({ error: "questionIds and answers must match in length" });
    }

    for (let i = 0; i < questionIds.length; i++) {
      const questionId = questionIds[i];
      const answer = Array.isArray(answers[i]) ? answers[i] : [answers[i]];

      await sql`
        INSERT INTO user_response (user_id, question_id, answers)
        VALUES (${userId}, ${questionId}, ${answer})
        ON CONFLICT (user_id, question_id)
        DO UPDATE SET answers = ${answer};
      `;
    }

    res.json({ message: "Responses saved successfully" });

  } catch (err) {
    console.log(err);
    res.status(500).json({ error: "Database Error", details: err.message });
  }
});

// ===============================
// ROUTES (from File 2)
// ===============================
app.use('/api/normal-user', normalUserRoutes);
app.use('/api/org-user', organisationUserRoutes);
app.use('/api', authRoutes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'Server is healthy' });
});

// Root route (for browser test)
app.get('/', (req, res) => {
  res.send('🚀 Backend is running');
});

// ===============================
// DB CONNECTION CHECK
// ===============================
const checkDbConnection = async () => {
  try {
    const client = await pool.connect();
    console.log('✅ Supabase database connected successfully');

    await client.query('SELECT NOW()');
    client.release();
  } catch (err) {
    console.error('❌ Database connection failed:', err.message);
    process.exit(1);
  }
};

// ===============================
// GLOBAL ERROR HANDLER
// ===============================
app.use((err, req, res, next) => {
  console.error('❌ Server Error:', err);
  res.status(500).json({ error: 'Internal server error' });
});

// ===============================
// START SERVER
// ===============================
const startServer = async () => {
  await checkDbConnection();

  app.listen(PORT, () => {
    console.log(`🚀 Server running on http://localhost:${PORT}`);
  });
};

startServer();
