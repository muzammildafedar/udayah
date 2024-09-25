import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'package:http/http.dart' as http;

class EncryptionHelper {
  static final key = encrypt.Key.fromUtf8("aIopEsdhAamkse@nmandsoplQhIdae13"); // Ensure this is the same as in Node.js

  static String decrypt(String encryptedData, String ivBase64) {
    final iv = encrypt.IV.fromBase64(ivBase64); // Convert IV from base64 to bytes
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    try {
      // Decrypt the encrypted data using the same IV
      final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
      return decrypted;
    } catch (e) {
      // print('Decryption error: $e');
      throw Exception('Failed to decrypt data');
    }
  }
}
