import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/navigation/page_navigation.dart';
import 'package:ourpass_auth_project/provider/auth_provider.dart';
import 'package:ourpass_auth_project/screens/auth/login.dart';
import 'package:ourpass_auth_project/screens/auth/verification.dart';
import 'package:ourpass_auth_project/screens/components/auth_components.dart';
import 'package:ourpass_auth_project/screens/components/textfield.dart';
import 'package:ourpass_auth_project/style/style.dart';
import 'package:ourpass_auth_project/utils/validator.dart';
import 'package:ourpass_auth_project/widgets/custom_button.dart';
import 'package:ourpass_auth_project/widgets/my_snackbar.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                    "Get Started",
                    "Kindly fill in the information below to get started.",
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //FIRST NAME TEXTFIELD
                      Container(
                        padding: const EdgeInsets.all(2),
                        width: screenWidth * .4,
                        child: CustomTextField(
                          readOnly: auth.isLoading ? true : false,
                          label: "First name",
                          hint: "e.g, John",
                          obscureText: false,
                          controller: firstNameController,
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? 'Field cannot be empty'
                                : null;
                          },
                        ),
                      ),

                      //LAST NAME TEXTFIELD
                      Container(
                        padding: const EdgeInsets.all(2),
                        width: screenWidth * .4,
                        child: CustomTextField(
                          readOnly: auth.isLoading ? true : false,
                          label: "Last name",
                          hint: "e.g, Doe",
                          obscureText: false,
                          controller: lastNameController,
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? 'Field cannot be empty'
                                : null;
                          },
                        ),
                      ),
                    ],
                  ),

                  //EMAIL TEXT FIELD
                  CustomTextField(
                    readOnly: auth.isLoading ? true : false,
                    label: "Email",
                    hint: "e.g, johndoe@gmail.com",
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    obscureText: false,
                    validator: (value) => Validators.validateEmail(value),
                  ),

                  //PASSWORD TEXTFIELD
                  CustomTextField(
                    readOnly: auth.isLoading ? true : false,
                    label: "Password",
                    hint: "Type your password",
                    controller: passwordController,
                    inputType: TextInputType.emailAddress,
                    obscureText: isObscure,
                    suffix:  Icon(
                      isObscure
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                    ).onTap(() {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    }),
                    validator: (input) => Validators.validatePassword()(input),
                  ),

                  //CONFIRM PASSWORD FIELD
                  CustomTextField(
                    readOnly: auth.isLoading ? true : false,
                    label: "Confirm password",
                    hint: "Re-enter password",
                    obscureText: isObscure2,
                    suffix:  Icon(
                      isObscure2
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                    ).onTap(() {
                      setState(() {
                        isObscure2 = !isObscure2;
                      });
                    }),
                    controller: confirmPasswordController,
                    validator: (input) => Validators.validatePassword()(input),
                  ),
                  auth.isLoading
                      ? const Padding(
                    padding:  EdgeInsets.symmetric(vertical: 16.0),
                    child:  Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),),
                  )
                      : CustomButton(
                          action: () {
                            if (_formKey.currentState!.validate()) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                auth.registerWithEmailAndPassword(
                                  context,
                                  emailController.text.trim(),
                                  passwordController.text,
                                  firstNameController.text.trim(),
                                  lastNameController.text.trim(),
                                  const VerificationScreen(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    mySnackbar("Passwords do not match!"));
                              }
                            }
                          },
                          label: "Sign up",
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account? ",
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: auth.isLoading ? null : () => PageNavigation()
                            .replace(context, const LoginScreen()),
                        child: const Text(
                          "Sign in",
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
