import 'package:flutter/material.dart';

import '../style/style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? action;
  final String label;

  const CustomButton({
    Key? key,
    required this.action,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 57,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
                elevation: MaterialStateProperty.all(0)),
            onPressed: action,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )),
      );
}
