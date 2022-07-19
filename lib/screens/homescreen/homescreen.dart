import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/global/global.dart';
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
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Home screen",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: firebaseFirestore
                      .collection("users")
                      .doc(fAuth.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          strokeWidth: 3,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              const CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 100,
                                child: Icon(
                                  CupertinoIcons.person,
                                  color: AppColors.whiteColor,
                                  size: 70,
                                ),
                              ),
                              Positioned(
                                  right: 7,
                                  bottom: 7,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: AppColors.whiteColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      snapshot.data!["verified"]
                                          ? Icons.verified_user_sharp
                                          : Icons.cancel_rounded,
                                      color: snapshot.data!["verified"]
                                          ? AppColors.primaryColor
                                          : AppColors.error,
                                    ),
                                  ))
                            ],
                          ),
                          const Gap(32),
                          Text(
                            "${snapshot.data!["first name"]} ${snapshot.data!["last name"]}",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          const Gap(8),
                          Text(
                            "${snapshot.data!["email"]}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("No user data"),
                      );
                    }
                  }),
              TextButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlert(
                          title: "Sign out",
                          content:
                              "You are about to sign out of your account. Continue?",
                          action: () =>
                              Provider.of<AuthProvider>(context, listen: false)
                                  .signOut(context),
                        );
                      }),
                  child: Text(
                    "Log out",
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
