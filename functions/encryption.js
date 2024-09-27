const crypto = require('crypto');
const algorithm = 'aes-256-cbc'; // AES encryption algorithm
const key = Buffer.from(process.env.ENCRYPTION_KEY, 'utf8').slice(0, 32); // Ensure key is 32 bytes

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

module.exports = {
  encrypt,
};
