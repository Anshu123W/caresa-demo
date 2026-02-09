import express from 'express';
import { signupOrganisationUser } from '../controllers/organisationUser.controller.js';

const router = express.Router();
router.post('/signup', signupOrganisationUser);

export default router;
