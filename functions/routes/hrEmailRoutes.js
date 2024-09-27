const { body } = require('express-validator');
const hrEmailController = require('../controllers/hrEmailController');
const express = require('express');

const router = express.Router();

// POST endpoint to store hr email
router.post('/api/add-hr-email', [
    body('email_address').isEmail().withMessage('Must be a valid email address'),
    body('company_name').notEmpty().withMessage('Company name is required'),
    body('website').optional().isURL().withMessage('Must be a valid URL'),
], hrEmailController.addHREmail);

module.exports = router;
