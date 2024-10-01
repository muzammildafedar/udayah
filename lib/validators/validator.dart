// validators.dart
import 'package:flutter/material.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a company name';
    }
    return null;
  }

  static String? validateWebsite(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a website';
    }
    return null;
  }
}
