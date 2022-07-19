import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/provider/auth_provider.dart';
import 'package:ourpass_auth_project/screens/auth/signup.dart';
import 'package:ourpass_auth_project/style/style.dart';
import 'package:ourpass_auth_project/widgets/custom_button.dart';
import 'package:ourpass_auth_project/widgets/my_snackbar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../global/global.dart';
import '../../navigation/page_navigation.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Consumer<AuthProvider>(builder: (context, auth, child) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Verify Email",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Gap(16),
                Text(
                  "Enter the four-digit pin sent to ${fAuth.currentUser!.email}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.subColor,
                    fontSize: 14,
                  ),
                ),
                const Gap(24),
                Pinput(
                  length: 4,
                  controller: otpController,
                  validator: (pin) {
                    return pin == '1234' ? null : 'Pin is incorrect';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                ),
                const Gap(32),
                const Text(
                  "Code is 1234",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                auth.isLoading
                    ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
                    : CustomButton(
                    action: () {
                      if (_formKey.currentState!.validate()) {
                        auth.authenticateOTP(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar("Incorrect otp. Otp is 1234"));
                      }
                    },
                    label: "Submit"),
                const Gap(16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Incorrect Email? ",
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onTap: auth.isLoading ? null : () => PageNavigation()
                          .replace(context, const SignUpScreen()),
                      child: const Text(
                        "Use another email",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
