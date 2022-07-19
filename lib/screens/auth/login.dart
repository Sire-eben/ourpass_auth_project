import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/navigation/page_navigation.dart';
import 'package:ourpass_auth_project/provider/auth_provider.dart';
import 'package:ourpass_auth_project/screens/auth/signup.dart';
import 'package:ourpass_auth_project/screens/auth/verification.dart';
import 'package:ourpass_auth_project/screens/components/auth_components.dart';
import 'package:ourpass_auth_project/screens/components/textfield.dart';
import 'package:ourpass_auth_project/style/style.dart';
import 'package:ourpass_auth_project/utils/validator.dart';
import 'package:ourpass_auth_project/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          padding: const EdgeInsets.all(24),
          child: Consumer<AuthProvider>(builder: (context, auth, child) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthComponents().compoTexts(
                    context,
                    "Welcome Back",
                    "Kindly login to your account.",
                  ),
                  const Gap(16),

                  //EMAIL TEXTFIELD
                  CustomTextField(
                    readOnly: auth.isLoading ? true : false,
                    label: "Email",
                    hint: "e.g, johndoe@gmail.com",
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    validator: (value) => Validators.validateEmail(value),
                  ),

                  //PASSWORD TEXTFIELD
                  CustomTextField(
                    readOnly: auth.isLoading ? true : false,
                    label: "Password",
                    hint: "Enter password",
                    controller: passwordController,
                    inputType: TextInputType.emailAddress,
                    obscureText: isObscure,
                    suffix: Icon(
                      isObscure ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    ).onTap(() {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    }),
                    validator: (input) => Validators.validatePassword()(input),
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
                              auth.signInWithEmailAndPassword(
                                  context,
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  const VerificationScreen());
                            }
                          },
                          label: "Login",
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: auth.isLoading
                            ? null
                            : () => PageNavigation()
                                .replace(context, const SignUpScreen()),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
