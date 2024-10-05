import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udayah/data/constants.dart';
import 'dart:convert';

import 'package:udayah/models/hr_emails.dart';

class HrEmailProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String> addHrEmail(HrEmail hrEmail) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}/add-hr-email'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(hrEmail.toJson()),
      );

      if (response.statusCode == 201) {
        // Handle success
        final responseData = jsonDecode(response.body);
        return responseData['success'];
      } else {
        // Handle failure
        final responseData = jsonDecode(response.body);
        String errorMessage = responseData['errors'][0]["msg"];
        throw Exception('Failed: ${errorMessage}');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
