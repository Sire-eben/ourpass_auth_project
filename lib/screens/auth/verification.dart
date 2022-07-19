import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/screens/auth/otpverify.dart';
import 'package:ourpass_auth_project/screens/homescreen/homescreen.dart';
import 'package:ourpass_auth_project/style/style.dart';

import '../../global/global.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: firebaseFirestore
            .collection("users")
            .doc(fAuth.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : snapshot.data!['verified'] == false
                  ? const OTPScreen()
                  : const HomeScreen();
        });
  }
}
