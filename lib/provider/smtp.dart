import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SmtpProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeSmtpDetails({
     String ? email,
    required String smtpServer,
    required String smtpPort,
    required String smtpUsername,
    required String smtpPassword,
    required BuildContext context
  }) async {
    try {
      await _firestore.collection('smtp_details').doc(email).set({
        'smtp_server': smtpServer,
        'smtp_port': smtpPort,
        'smtp_username': smtpUsername,
        'smtp_password': smtpPassword,
      });
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('SMTP settings saved.')),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, String>?> getSmtpDetails(String ? email) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('smtp_details').doc(email).get();
      if (doc.exists) {
        return {
          'smtp_server': doc['smtp_server'],
          'smtp_port': doc['smtp_port'],
          'smtp_username': doc['smtp_username'],
          'smtp_password': doc['smtp_password'],
        };
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
