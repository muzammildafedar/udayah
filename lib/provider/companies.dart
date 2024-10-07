import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udayah/data/constants.dart';
import 'package:udayah/encryption.dart';
import 'package:udayah/models/companies_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CompaniesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CompaniesEmail> _emails = [];
  List<CompaniesEmail> _filteredEmails = [];
  bool _loading = true;
  String _selectedEmail = '';
  bool _visible = false;
  bool get visible => _visible; 
  String _addedBy = '';

  String get addedBy => _addedBy;

  List<CompaniesEmail> get emails => _filteredEmails;
  bool get loading => _loading;
  String get selectedEmail => _selectedEmail;

  CompaniesProvider() {
    fetchEmails();
  }
  selectEmailAddress(String val, bool visible, String added_by) {
    _addedBy = added_by;
     _visible = visible;
    _selectedEmail = val;
    notifyListeners();
  }
  deselectEmailAddress() {
    _addedBy = '';
    _visible = false;
    _selectedEmail = '';
    notifyListeners();
  }

  Future<List<CompaniesEmail>> fetchEmails() async {
    String apiUrl = '${baseUrl}/companies';
    _loading = true;
    notifyListeners();

    try {
      log("Fetching emails from: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));
      log("Response: ${response.body}");
      log("Response Code: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final decryptedData =
            EncryptionHelper.decrypt(data['encryptedData'], data['iv']);
        final jsonData = jsonDecode(decryptedData) as List<dynamic>;

        _emails = jsonData
            .map(
                (json) => CompaniesEmail.fromJson(json as Map<String, dynamic>))
            .toList();
        _filteredEmails = List.from(_emails);
        notifyListeners();

        return _emails;
      } else {
        throw Exception('Failed to load emails..');
      }
    } catch (e) {
      print("Error fetching emails: $e");
      return []; // Return an empty list in case of an error
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void searchEmails(String query) {
    if (query.isEmpty) {
      _filteredEmails = List.from(_emails);
    } else {
      _filteredEmails = _emails.where((email) {
        return email.emailAddress.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
