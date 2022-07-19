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
  Future registerWithEmailAndPassword(
      BuildContext context,
      String email,
      String password,
      String firstName,
      String lastName,
      Widget newPage) async {
    User? currentUser;
    _isLoading = true;
    notifyListeners();
    try {
      //TRY TO CREATE ACCOUNT USING EMAIL & PASSWORD PROVIDED
      await fAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((auth) => currentUser = auth.user);
    } on FirebaseAuthException catch (e) {
      //IF THERE IS ANY ERROR, SHOW ERROR AND STOP AUTHENTICATION
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(e.message!));
    }

    //IF THERE ARE NO EXCEPTIONS, SAVE USER DATA AND MOVE TO VERIFICATION SCREEN
    if (currentUser != null) {
      saveDataToFirestore(currentUser, firstName, lastName).whenComplete(() {
        _isLoading = false;
        notifyListeners();
        //SEND TO VERIFICATION SCREEN
        PageNavigation().replace(context,  VerificationScreen(
        ));
      });
    }
    notifyListeners();
  }

  //SAVE USER'S DATA TO FIRESTORE & SET DATA LOCALLY
  Future saveDataToFirestore(
      User? currentUser, String firstName, lastName) async {
    await firebaseFirestore.collection("users").doc(currentUser!.uid).set(
      {
        "uid": fAuth.currentUser!.uid,
        "email": fAuth.currentUser!.email,
        "first name": firstName,
        "last name": lastName,
        "verified": false,
      },
    );
    notifyListeners();
  }

//USER SIGN IN METHOD
  Future signInWithEmailAndPassword(
    BuildContext context,
    String email,
    password,
    Widget newPage,
  ) async {
    User? currentUser;
    _isLoading = true;
    notifyListeners();
    try {
      await fAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((auth) {
        currentUser = auth.user!;
        if (currentUser != null) {
          checkIfUserExist(context, currentUser);
        }
      });
      notifyListeners();
    } on FirebaseAuthException {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(
          "Something went wrong. Please check your email/password."));
    }
    notifyListeners();
  }

  //CHECK IF EMAIL EXIST IN DATABASE
  Future checkIfUserExist(BuildContext context, User? currentUser) async {
    await firebaseFirestore
        .collection("users")
        .doc(currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        _isLoading = false;
        notifyListeners();
        PageNavigation().replace(context, const VerificationScreen());
      } else {
        //IF USER DOESN'T EXIST IN DATABASE, THROW ERROR
        fAuth.signOut();
        _isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar("Account does not exist!"),
        );
      }
    });
  }

  //OTP AUTHENTICATION METHOD
  Future authenticateOTP(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      await firebaseFirestore
          .collection("users")
          .doc(fAuth.currentUser!.uid)
          .update({
        "verified": true,
      }).whenComplete(() {
        _isLoading = false;
        PageNavigation().replace(context, const VerificationScreen());
      });
    } on FirebaseException {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(mySnackbar("Something went wrong"));
    }
    notifyListeners();
  }

//USER SIGN OUT METHOD
  signOut(BuildContext context) async {
    try {
      await fAuth.signOut().then((value) {
        PageNavigation().remove(context, const LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(mySnackbar(e.message!));
    }
    notifyListeners();
  }
}
