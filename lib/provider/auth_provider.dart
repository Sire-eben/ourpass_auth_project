import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/global/global.dart';

class AuthProvider with ChangeNotifier {
  //SETTER
  bool _isLoading = false;

//GETTER
  bool get isLoading => _isLoading;

  Future<void> registerWithEmailAndPassword(
    BuildContext? context,
    String _email,
    String _password,
    String firstName,
    String lastName,
  ) async {
    _isLoading = true;

    await fAuth
        .createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    )
        .whenComplete(() {
      firebaseFirestore.collection("users").doc(fAuth.currentUser!.uid).set({
        "first name": firstName,
        "last name": lastName,
        "email": _email,
      });
    }).then((value) {
      _isLoading = false;
    });

    notifyListeners();
  }

  void signOut(BuildContext? context) {
    fAuth.signOut().then((value) {});
  }
}
