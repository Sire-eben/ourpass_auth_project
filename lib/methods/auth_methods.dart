import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationMethods {
  Future<void> registerWithEmailAndPassword(
      BuildContext context, String _email, _password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password);
  }
}
