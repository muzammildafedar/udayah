const { body } = require('express-validator');
const sendEmailController = require('../controllers/sendEmailController');
const express = require('express');

const router = express.Router();

// POST endpoint to store hr email
router.post('/api/send-email', [
    body('smtpDetails')
        .exists().withMessage('smtp Details are required')
        .notEmpty().withMessage('smtp details can not be empty'),
    body('resumeUrl')
        .exists().withMessage('resumeUrl field is required')
        .isURL().withMessage('Must be a valid URL'),
    body('from')
        .exists().withMessage('the to field is required')
        .isEmail().withMessage('the sender email (from) must be valid'),
    body('to')
        .exists().withMessage('the to field is required')
        .isEmail().withMessage('the reciver email (to) must be valid'),
    body('subject')
        .exists().withMessage('subject is required')
        .notEmpty().withMessage('subject must not be empty'),
    body('body')
        .exists().withMessage('body is required')
        .notEmpty().withMessage('Body cannot be empty'),
], sendEmailController.sendEmail);

module.exports = router;
