require('dotenv').config();
const express = require('express');
const nodemailer = require('nodemailer');
const axios = require('axios');
const { Readable } = require('stream');
const fs = require('fs');
const path = require('path');
const cors = require('cors');
const app = express();
const crypto = require('crypto');
const algorithm = 'aes-256-cbc'; // AES encryption algorithm
const key = Buffer.from(process.env.ENCRYPTION_KEY, 'utf8').slice(0, 32); // Ensure key is 32 bytes
const port = process.env.PORT || 3000;

app.use(cors({
  origin: '*', // Update if needed
  methods: 'GET, POST, PUT, DELETE, OPTIONS',
  allowedHeaders: 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
}));
// app.use('/.well-known', express.static(path.join(__dirname, '.well-known')));
//app.use(cors());
app.use(express.json());
app.get('/', async (req, res) => {
      res.status(200).json({ success: 'Working bro..' });
});
//app.us('/.well-known', express.static(path.join(__dirname, '.well-known')));



// Encryption function with a random IV
function encrypt(text) {
  const iv = crypto.randomBytes(16); // Generate a random 16-byte IV
  const cipher = crypto.createCipheriv(algorithm, key, iv);
  let encrypted = cipher.update(text, 'utf8', 'base64');
  encrypted += cipher.final('base64');

  // Return both the IV and the encrypted data as base64
  return {
    iv: iv.toString('base64'),
    encryptedData: encrypted,
  };
}

app.post('/api/send-email', async (req, res) => {
  const { smtpDetails, resumeUrl, from, to, subject, body } = req.body;

  if (!smtpDetails || !resumeUrl || !from || !to || !subject || !body) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  try {
    // Create a Nodemailer transporter using the SMTP details
    const transporter = nodemailer.createTransport({
      logger: true,  // Enables logging
      debug: true,   // Enable debugging output
    
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
          filename: 'resume.pdf', // Adjust the filename as needed
          content: attachmentStream,
        },
      ],
    });

    res.status(200).json({ message: 'Email sent', info });
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).json({ error: 'Failed to send email', log: error });
  }
});
app.get('/api/companies', async (req, res) => {
  const filePath = path.join(__dirname, 'emails.json');

  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading the file:', err);
      return res.status(500).json({ error: 'Failed to read the file' });
    }

    try {
      const jsonData = JSON.parse(data);
      
      // Encrypt JSON data
      const encryptedData = encrypt(JSON.stringify(jsonData));

      // Send encrypted JSON response
      res.json(encryptedData);
    } catch (parseErr) {
      console.error('Error parsing JSON:', parseErr);
      res.status(500).json({ error: 'Failed to parse JSON' });
    }
  });
});
// POST endpoint to store email data in emails.json
app.post('/api/add-email', (req, res) => {
  const { email_id, email_address, added_by } = req.body;

  if (!email_id || !email_address || !added_by) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  // Construct the new email object
  const newEmailEntry = {
    email_id,
    email_address,
    added_by,
    visible: false
  };

  const filePath = path.join(__dirname, 'emails.json');

  // Read the current data in emails.json
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      console.error('Error reading emails.json:', err);
      return res.status(500).json({ error: 'Failed to read the emails file' });
    }

    try {
      // Parse the existing data in emails.json
      let emailsData = JSON.parse(data);

      // Append the new email entry to the emails array
      emailsData.push(newEmailEntry);

      // Write the updated data back to emails.json
      fs.writeFile(filePath, JSON.stringify(emailsData, null, 2), (writeErr) => {
        if (writeErr) {
          console.error('Error writing to emails.json:', writeErr);
          return res.status(500).json({ error: 'Failed to update the emails file' });
        }

        // Respond with success
        res.status(200).json({ message: 'Email entry added successfully', email: newEmailEntry });
      });

    } catch (parseErr) {
      console.error('Error parsing JSON:', parseErr);
      return res.status(500).json({ error: 'Failed to parse the emails file' });
    }
  });
});


app.listen(port, () => {
  console.log('Server running on port 3000');
});
