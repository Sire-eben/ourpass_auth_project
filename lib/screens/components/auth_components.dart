import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../style/style.dart';

class AuthComponents {
  Widget compoTexts(BuildContext context, String header, subText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        const Gap(8),
        Text(
          subText,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.subColor,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}
