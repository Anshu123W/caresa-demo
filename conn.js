import sql from './backend/dbconn.js';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

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
