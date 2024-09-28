const { body,param } = require('express-validator');
const hrEmailController = require('../controllers/hrEmailController');
const express = require('express');


const router = express.Router();

// POST endpoint to store hr email
router.post('/api/add-hr-email', [
    body('email_address').isEmail().withMessage('Must be a valid email address'),
    body('company_name').notEmpty().withMessage('Company name is required'),
    body('website').isURL().withMessage('Must be a valid URL'),
    body('added_by')
        .exists().withMessage('the user email is required')
        .isEmail().withMessage('Must be a valid email'),
], hrEmailController.addHREmail);

router.get('/api/companies/:company_id?', [
    param('company_id')
        .optional()
        .isInt({ gt: 0 }).withMessage('Company ID must be a positive integer'),],
    hrEmailController.fetchCompanies,);


module.exports = router;
