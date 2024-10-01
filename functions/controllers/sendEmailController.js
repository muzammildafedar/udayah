const { validationResult } = require('express-validator');
const nodemailer = require('nodemailer');
const axios = require('axios');
const { Readable } = require('stream');


const sendEmail = async (req, res) => {
    try {

        const { smtpDetails, resumeUrl, from, to, subject, body } = req.body;
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(400).json({ errors: errors.array() });
        }
        // Create a Nodemailer transporter using the SMTP details
        const transporter = nodemailer.createTransport({
            logger: true,  // Enables logging
            // debug: true,   // Enable debugging output

            host: smtpDetails.host,
            port: smtpDetails.port,
            secure: smtpDetails.secure, // true for 465, false for other ports
            auth: {
                user: smtpDetails.user,
                pass: smtpDetails.pass,
            },
        });

        // Download the resume file from the URL
        const response = await axios({
            url: resumeUrl,
            method: 'GET',
            responseType: 'stream',
        });

        const attachmentStream = new Readable().wrap(response.data);

        // Send the email
        const info = await transporter.sendMail({
            from,
            to,
            subject,
            html: body,
            attachments: [
                {
                    filename: 'Resume.pdf', // Adjust the filename as needed
                    content: attachmentStream,
                },
            ],
        });

        res.status(200).json({ message: 'Email sent', info });
    } catch (error) {
        console.error('Error sending email:', error);
        res.status(500).json({ error: 'Failed to send email', log: error });
    }
};

// Export the controller functions
module.exports = {
    sendEmail,
};
