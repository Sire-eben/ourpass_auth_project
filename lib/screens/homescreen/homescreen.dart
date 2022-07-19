import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/provider/auth_provider.dart';
import 'package:ourpass_auth_project/style/style.dart';
import 'package:ourpass_auth_project/widgets/custom_alert.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home screen"),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlert(
                      title: "Sign out",
                      content:
                      "You are about to sign out of your account. Continue?",
                      action: () => Provider.of<AuthProvider>(
                          context,
                          listen: false)
                          .signOut(context),
                    );
                  }),
              icon: const Icon(
                Icons.logout,
                color: AppColors.whiteColor,
              ))
        ],
      ),
    );
  }
}
