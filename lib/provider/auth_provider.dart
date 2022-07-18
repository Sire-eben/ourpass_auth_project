import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/global/global.dart';
import 'package:ourpass_auth_project/navigation/page_navigation.dart';

import '../screens/auth/login.dart';

class AuthProvider with ChangeNotifier {
  //SETTER
  bool _isLoading = false;

//GETTER
  bool get isLoading => _isLoading;

  Future<void> registerWithEmailAndPassword(
      BuildContext context,
      String _email,
      String _password,
      String firstName,
      String lastName,
      Widget newPage) async {
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
      PageNavigation().remove(context, newPage);
    });

    notifyListeners();
  }

  void signInWithEmailAndPassword(
      BuildContext context, String _email, _password, Widget newPage) async {
    await fAuth
        .signInWithEmailAndPassword(email: _email, password: _password)
        .whenComplete(() {
      PageNavigation().remove(context, newPage);
    });
    notifyListeners();
  }

  void signOut(BuildContext context) {
    _isLoading = true;
    fAuth.signOut().then((value) {
      _isLoading = false;
      PageNavigation().push(context, const LoginScreen());
    });
    notifyListeners();
  }
}
