const HREmail = require('../models/HrEmail');
const { validationResult } = require('express-validator');


const addHREmail = async (req, res) => {

    const { email_address, company_name, website } = req.body;

    try {

        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        // Check for duplicate email
        const existingEmail = await HREmail.findOne({ where: { email_address } });

        if (existingEmail) {
            return res.status(409).json({ error: 'Email address already exists' });
        }

        //add email to database
        const newHREmail = await HREmail.create({
            email_address,
            company_name,
            website,
        });
        res.status(201).json(newHREmail);
    } catch (error) {
        console.error('Error adding HR email:', error);
        res.status(500).json({ error: 'Failed to add HR email' });
    }
};

// Export the controller functions
module.exports = {
    addHREmail,
};
