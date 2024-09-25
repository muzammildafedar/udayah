import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithPopup(GoogleAuthProvider());
      _user = userCredential.user;
      // print(_user);
      print("Hogaya bhai...");

      // Redirect to dashboard after successful sign-in
      if (_user != null) {
        GoRouter.of(context).go('/dashboard');
      }

      notifyListeners();
    } catch (e) {
      // print("Error during Google sign-in: $e");
    }
  }

  Future<void> signOut(context) async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
    GoRouter.of(context).go('/');
  }
}
