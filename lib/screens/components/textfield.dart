import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/style/style.dart';

class CustomTextField extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final bool obscureText;

  const CustomTextField(
      {Key? key,
      required this.label,
      this.inputType,
      this.validator,
      required this.obscureText,
      required this.controller,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(
              color: AppColors.subColor,
              fontSize: 14,
            ),
          ),
          const Gap(8),

          //TEXTFIELD
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.subColor,
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.subColor,
                  )),
              errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                width: 2,
                color: AppColors.error,
              )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColors.primaryColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
