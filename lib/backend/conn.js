
import sql from './dbconn.js';
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { randomUUID } from 'crypto';

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());


app.get("/", (req, res) => {
  res.json({ success: true, message: "Server is running!" });
});


app.post("/get-user-id", async (req, res) => {
  try {
    const { firebaseUid } = req.body;

    if (!firebaseUid) {
      return res.status(400).json({ error: "Firebase UID is required!" });
    }

    const result = await sql`
      SELECT user_id FROM users_ WHERE firebase_uid = ${firebaseUid}
    `;

    if (result.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    res.json({ success: true, userId: result[0].user_id });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database Error", details: err.message });
  }
});

app.post("/complaint", async (req, res) => {
  console.log('complaint is responding ')
  try {
    const userId ='b8a13133-8b32-4b37-a9cb-74ad18992b85'; 
    console.log('Useridtoconsole :D ',userId) 
    const {
     
      is_anonymous,
      name,
      category,
      description,
      complaint_date,
      complaint_time,
      location,
    } = req.body;

    console.log('Destructured values:');
    console.log('- userId:', userId);
    console.log('- is_anonymous:', is_anonymous);
    console.log('- name:', name);
    console.log('- category:', category);
    console.log('- description length:', description?.length);
    console.log('- complaint_date:', complaint_date);
    console.log('- complaint_time:', complaint_time);
    console.log('- location:', location);
    if (!category || !description || !complaint_date || !complaint_time || !location) {
      return res.status(400).json({ error: "Missing required fields" });
    }

  if (!is_anonymous) {
  if (!name || typeof name !== 'string' || name.trim() === "") {
    return res.status(400).json({ error: "Name is required for named complaints" });
  }
}
    const referencerecent = await sql`
    SELECT reference_id 
    FROM complaints 
    ORDER BY created_at DESC 
    LIMIT 1
  `;

  let nextNumber = 1;

  if (referencerecent.length > 0 && referencerecent[0].reference_id) {
    const lastId = referencerecent[0].reference_id;
    const numberPart = parseInt(lastId.split('-')[1], 10);
    nextNumber = numberPart + 1;
  }


    const complaint_id = `POSH-${randomUUID().slice(0, 8)}`;
    const reference_id =`REF-${String(nextNumber).padStart(6, '0')}`;
    await sql`
      INSERT INTO complaints (
        user_id,
        complaint_id,
        is_anonymous,
        name,
        category,
        description,
        complaint_date,
        complaint_time,
        reference_id,
        location
      ) VALUES (
       ${userId},
        ${complaint_id},
        ${is_anonymous},
        ${is_anonymous ? null : name},
        ${category},
        ${description},
        ${complaint_date},
        ${complaint_time},
        ${reference_id},
        ${location}
      )
    `;

    res.status(200).json({
      success: true,
      complaint_id,
      reference_id,
      message: "Complaint saved successfully!",
    });
    
    console.log(`Complaint saved: ${complaint_id}`);

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database Error", details: err.message });
  }
});



app.get("/complaint/latest/:userId", async (req, res) => {
  try {
    const { userId } = req.params;

    if (!userId) {
      return res.status(400).json({ error: "User ID is required" });
    }

    const result = await sql`
      SELECT complaint_id, reference_id, created_at
      FROM complaints
      WHERE user_id = ${userId}
      ORDER BY created_at DESC
      LIMIT 1
    `;

    if (result.length === 0) {
      return res.status(404).json({ error: "No complaints found for user" });
    }

    res.status(200).json({
      success: true,
      complaint_id: result[0].complaint_id,
      reference_id: result[0].reference_id,
      created_at: result[0].created_at,
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database Error", details: err.message });
  }
});








app.post("/responses", async (req, res) => {
  try {
    const { userId, questionIds, answers } = req.body;

  
    if (!userId || !questionIds || !answers) {
      return res.status(400).json({ error: "Missing required fields" });
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

    res.status(200).json({ success: true, message: "Responses saved successfully" });
    console.log(`Responses saved for user: ${userId}`);

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database Error", details: err.message });
  }
});


const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});