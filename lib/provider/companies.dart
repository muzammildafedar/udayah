import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shippi/data/constants.dart';
import 'package:shippi/encryption.dart';
import 'package:shippi/models/companies_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CompaniesProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CompaniesEmail> _emails = [];
  List<CompaniesEmail> _filteredEmails = [];
  bool _loading = true;
  String _selectedEmail = '';

  List<CompaniesEmail> get emails => _filteredEmails;
  bool get loading => _loading;
  String get selectedEmail => _selectedEmail;

  CompaniesProvider() {
    fetchEmails();
  }
  selectEmailAddress(String val) {
    _selectedEmail = val;
    notifyListeners();
  }

  Future<List<CompaniesEmail>> fetchEmails() async {
    String apiUrl = '${baseUrl}/companies';
    _loading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));

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
