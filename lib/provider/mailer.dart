import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:udayah/data/constants.dart';
import 'package:udayah/widgets/alerts.dart';

class EmailProvider with ChangeNotifier {
  String? selectedFileName;
  String? selectedFilePath;
  Uint8List? selectedFileBytes;
  bool _loading = false;
  bool get loading => _loading;

  Future<http.Response> sendEmail({
    required String? to,
    required String subject,
    required String body,
    required BuildContext context,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    _loading = true;
    notifyListeners();

    String apiUrl = '${baseUrl}/send-email';
    if (user == null) {
      ShowCustomDialog(context, "No user is currently logged in");
    }

    final smtpDetails = await _getSmtpDetails(user!.email!);
    final resumeUrl = await getLatestResumeUrl();
    if (smtpDetails == null) {
      _loading = false;
      notifyListeners();
    }
    final Map<String, dynamic> requestBody = {
      "smtpDetails": {
        "host": "${smtpDetails!['smtp_server']}",
        "port": "${smtpDetails['smtp_port']}",
        "secure": false,
        "user": "${smtpDetails['smtp_username']}",
        "pass": "${smtpDetails['smtp_password'].replaceAll(' ', '')}",
      },
      "resumeUrl": "${resumeUrl!.replaceAll(' ', '')}",
      "from": "${user.email}",
      "to": "${to}",
      "subject": "${subject}",
      "body": "${body}",
    };
    // print(jsonEncode(requestBody));
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      // Successfully sent the email
      _loading = false;
      notifyListeners();
      return response;
    } else {
       _loading = false;
      notifyListeners();
      // Handle errors here
      throw Exception('Failed to send email: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>?> _getSmtpDetails(String userEmail) async {
    final smtpDoc = await FirebaseFirestore.instance
        .collection('smtp_details')
        .doc(userEmail)
        .get();

    if (smtpDoc.exists) {
      return smtpDoc.data()!;
    } else {
      return null;
      // throw Exception('SMTP details not found for user $userEmail');
    }
  }

  Future<void> uploadFile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated.");
    }

    final email = user.email;
    if (email == null) {
      throw Exception("User email is null.");
    }

    final fileName =
        selectedFileName ?? DateTime.now().millisecondsSinceEpoch.toString();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_files')
        .child(email)
        .child(fileName);

    try {
      // Upload the file (this will overwrite any existing file at the same reference)
      final uploadTask = storageRef.putData(selectedFileBytes!);
      await uploadTask.whenComplete(() => print("File uploaded successfully."));

      // Get the download URL of the uploaded file
      final downloadURL = await storageRef.getDownloadURL();

      // Prepare file metadata
      final fileMetadata = {
        'file_name': fileName,
        'file_path': downloadURL,
        'file_size': selectedFileBytes?.length,
        'uploaded_at': Timestamp.now(),
      };

      // Get a reference to the Firestore collection
      final filesCollection = FirebaseFirestore.instance
          .collection('user_files')
          .doc(email)
          .collection('files');

      // Check if the metadata already exists
      final existingFile =
          await filesCollection.where('file_name', isEqualTo: fileName).get();

      if (existingFile.docs.isNotEmpty) {
        // Update existing metadata
        final existingDoc = existingFile.docs.first;
        await existingDoc.reference.update(fileMetadata);
        print("File metadata updated successfully.");
      } else {
        // Add new metadata
        await filesCollection.add(fileMetadata);
        print("File metadata stored successfully.");
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to upload file and store metadata: $e');
    }
  }

  Future<Map<String, dynamic>?> getLatestResumeMetadata() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not authenticated.");
    }

    final email = user.email;
    if (email == null) {
      throw Exception("User email is null.");
    }

    try {
      final filesCollection = FirebaseFirestore.instance
          .collection('user_files')
          .doc(email)
          .collection('files');

      // Query for the most recent resume
      final querySnapshot = await filesCollection
          .orderBy('uploaded_at', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null; // No resume found
      }

      // Return the metadata of the latest resume
      return querySnapshot.docs.first.data();
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch resume metadata: $e');
    }
  }

  Future<String?> getLatestResumeUrl() async {
    final metadata = await getLatestResumeMetadata();
    await getLatestResumeName();
    return metadata?['file_path'];
  }

  Future<Map<String, String>?> getLatestResumeName() async {
    final metadata = await getLatestResumeMetadata();
    if (metadata == null) return selectedFileName = null;
    selectedFileName = metadata['file_name'];
    notifyListeners();

    // return {
    //   'file_name': metadata['file_name'] as String,
    //   'file_path': metadata['file_path'] as String,
    // };
  }

  void setSelectedFileName(String fileName) {
    selectedFileName = fileName;
    notifyListeners();
  }

  void setSelectedFilePath(String? path) {
    selectedFilePath = path;
    notifyListeners();
  }

  void setSelectedFileBytes(Uint8List? bytes) {
    selectedFileBytes = bytes;
    notifyListeners();
  }
}
