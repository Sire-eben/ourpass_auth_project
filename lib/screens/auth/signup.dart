import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/screens/components/auth_components.dart';
import 'package:ourpass_auth_project/screens/components/textfield.dart';
import 'package:ourpass_auth_project/style/style.dart';
import 'package:ourpass_auth_project/utils/validator.dart';
import 'package:ourpass_auth_project/widgets/custom_button.dart';

import '../../const/const.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
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

              //EMAIL TEXTFIELD
              CustomTextField(
                label: "Email",
                hint: "e.g, johndoe@gmail.com",
                controller: emailController,
                inputType: TextInputType.emailAddress,
                obscureText: false,
                validator: (value) => Validators.validateEmail(value),
              ),

              //PASSWORD TEXTFIELD
              CustomTextField(
                label: "Password",
                hint: "Type your password",
                controller: passwordController,
                inputType: TextInputType.emailAddress,
                obscureText: true,
                validator: (input) => Validators.validatePassword()(input),
              ),

              //CONFIRM PASSWORD FIELD
              CustomTextField(
                label: "Email",
                hint: "Re-enter password",
                obscureText: true,
                controller: confirmPasswordController,
                validator: (input) => Validators.validatePassword()(input),
              ),
              CustomButton(action: () {}, label: "Sign up")
            ],
          ),
        ),
      ),
    );
  }
}
