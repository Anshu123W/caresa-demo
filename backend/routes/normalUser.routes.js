import express from 'express';
import { signupNormalUser } from '../controllers/normalUser.controller.js';

const router = express.Router();

router.post('/signup', signupNormalUser);

export default router;
