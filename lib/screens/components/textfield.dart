import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ourpass_auth_project/style/style.dart';

class CustomTextField extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffix;

  const CustomTextField({
    Key? key,
    required this.label,
    this.inputType,
    this.validator,
    this.obscureText = false,
    required this.controller,
    required this.hint,
    this.readOnly = false,
    this.suffix,
  }) : super(key: key);

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
            readOnly: readOnly,
            controller: controller,
            keyboardType: inputType,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              iconColor: AppColors.subColor,
              hintText: hint,
              suffixIcon: suffix,
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

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback action, {bool opaque = true}) {
    return GestureDetector(
      behavior: opaque ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      onTap: action,
      child: this,
    );
  }
}
