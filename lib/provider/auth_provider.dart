import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/global/global.dart';
import 'package:ourpass_auth_project/navigation/page_navigation.dart';
import 'package:ourpass_auth_project/screens/auth/verification.dart';

import '../screens/auth/login.dart';
import '../widgets/my_snackbar.dart';

class AuthProvider with ChangeNotifier {
  //SETTER
  bool _isLoading = false;

//GETTER
  bool get isLoading => _isLoading;

//CREATE NEW USER ACCOUNT METHOD
  Future<void> registerWithEmailAndPassword(
      BuildContext context,
      String _email,
      String _password,
      String firstName,
      String lastName,
      Widget newPage) async {
    User? currentUser;
    _isLoading = true;
    try {
      //TRY TO CREATE ACCOUNT USING EMAIL & PASSWORD PROVIDED
      await fAuth
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((auth) {
        currentUser = auth.user;
      }).whenComplete(() {
        saveDataToFirestore(context, currentUser!, firstName, lastName)
            .then((value) {
          //SET STATE TO FALSE
          _isLoading = false;
          //SEND TO OTP VERIFICATION SCREEN
          PageNavigation().push(context, const VerificationScreen());
        });
      });
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      //IF THERE IS ANY ERROR, SHOW ERROR AND STOP AUTHENTICATION
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(e.message!));
    }
    notifyListeners();
  }

  //SAVE USER'S DATA TO FIRESTORE
  Future<void> saveDataToFirestore(BuildContext context, User? currentUser,
      String firstName, lastName) async {
    try {
      await firebaseFirestore.collection("users").doc(currentUser!.uid).set(
        {
          "uid": currentUser.uid,
          "email": currentUser.email,
          "first name": firstName,
          "last name": lastName,
          "verified": false,
        },
      );
    } on FirebaseException catch (e) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(e.message!));
    }
  }

//USER SIGN IN METHOD
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String _email, _password, Widget newPage) async {
    try {
      await fAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .whenComplete(() {
        PageNavigation().remove(context, newPage);
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(e.message!));
    }
    notifyListeners();
  }

//USER SIGN OUT METHOD
  void signOut(BuildContext context) async {
    _isLoading = true;
    try {
      await fAuth.signOut().then((value) {
        _isLoading = false;
        PageNavigation().push(context, const LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(e.message!));
    }
    notifyListeners();
  }
}
