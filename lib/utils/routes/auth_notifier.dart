import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }
}
