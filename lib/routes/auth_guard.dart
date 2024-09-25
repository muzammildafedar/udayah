import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard {
  bool isAuthenticated(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}

final authGuard = AuthGuard();
