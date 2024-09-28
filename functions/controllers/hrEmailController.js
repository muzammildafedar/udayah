const HREmail = require('../models/HrEmail');
const { validationResult } = require('express-validator');
const { encrypt } = require('../encryption');

const addHREmail = async (req, res) => {

    const { email_address, company_name, website, added_by } = req.body;

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
            added_by
        });
        res.status(201).json(newHREmail);
    } catch (error) {
        console.error('Error adding HR email:', error);
        res.status(500).json({ error: 'Failed to add HR email' });
    }
};

const fetchCompanies = async (req, res) => {

    try {

        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }

        const { company_id } = req.params;

        console.log(company_id)
        if (company_id) {
            //fetch the company with company_id
            const email = await HREmail.findByPk(company_id)
            if (!email) {
                return res.status(404).json({ message: 'email not found' });
            }
            // Encrypt the single email
            const encryptedEmail = encrypt(JSON.stringify(email.toJSON())); // Encrypt the email object
            return res.status(200).json(encryptedEmail);
        }
        else {
            //fetch all companies from database
            const emails = await HREmail.findAll()
            const plainEmails = emails.map(email => email.toJSON());

            //encrypt the data
            const encryptedEmails = encrypt(JSON.stringify(plainEmails))
            res.status(200).json(encryptedEmails)
        }
    } catch (error) {
        console.error('Error while fetching companies:', error);
        res.status(500).json({ error: 'Failed to get companies data' });
    }

};

// Export the controller functions
module.exports = {
    addHREmail,
    fetchCompanies,
};
