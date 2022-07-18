import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/global/global.dart';
import 'package:ourpass_auth_project/navigation/page_navigation.dart';
import 'package:ourpass_auth_project/screens/auth/login.dart';
import 'package:ourpass_auth_project/screens/auth/signup.dart';
import 'package:ourpass_auth_project/screens/homescreen/homescreen.dart';
import 'package:ourpass_auth_project/style/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() => Timer(const Duration(seconds: 3), () async {
        fAuth.currentUser != null
            ? PageNavigation().replace(context, const HomeScreen())
            : PageNavigation().replace(context, const SignUpScreen());
      });

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Image.asset('assets/icons/logo.png'),
      ),
    );
  }
}
