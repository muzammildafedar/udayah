const { validationResult } = require('express-validator');
const nodemailer = require('nodemailer');
const https = require('https');

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
            host: smtpDetails.host,
            port: 587,
            secure: false,
            requireTLS: true,
            auth: {
                user: smtpDetails.user,
                pass: smtpDetails.pass,
            },
        });

        const fileUrl = new URL(resumeUrl);
        const fileStream = await downloadFile(fileUrl);

        // Send the email
        const info = await transporter.sendMail({
            from,
            to,
            subject,
            html: body,
            attachments: [
                {
                    filename: '3YOE_Muzammil_D.pdf', // Adjust the filename as needed
                    content: fileStream,
                },
            ],
        });

        res.status(200).json({ message: 'Email sent', info });
    } catch (error) {
        console.error('Error sending email:', error);
        res.status(500).json({ error: 'Failed to send email', log: error });
    }
};

function downloadFile(url) {
    return new Promise((resolve, reject) => {
        https.get(url, (res) => {
            if (res.statusCode !== 200) {
                reject(new Error(`Failed to download file, status code: ${res.statusCode}`));
                return;
            }

            // The response object (`res`) is already a readable stream
            resolve(res); // Resolve with the stream itself
        }).on('error', (err) => {
            reject(err); // Handle error in the request
        });
    });
}

// Export the controller functions
module.exports = {
    sendEmail,
};
