import 'package:flutter/material.dart';
import 'package:ourpass_auth_project/style/style.dart';

class CustomAlert extends StatelessWidget {
  final String title, content;
  final VoidCallback action;

  const CustomAlert(
      {Key? key,
      required this.title,
      required this.content,
      required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
        ),
        titleTextStyle:
            const TextStyle(color: AppColors.subColor, fontSize: 21),
        contentTextStyle: const TextStyle(color: AppColors.subColor),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "No",
                style: TextStyle(color: AppColors.error),
              )),
          TextButton(onPressed: action, child: const Text("Yes")),
        ],
      );
}
