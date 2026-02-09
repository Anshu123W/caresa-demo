import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { pool } from './db.js';

import normalUserRoutes from './routes/normalUser.routes.js';
import organisationUserRoutes from './routes/organisationUser.routes.js';
import authRoutes from './routes/auth.routes.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

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
// ROUTES
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

    // Optional: quick test query
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
