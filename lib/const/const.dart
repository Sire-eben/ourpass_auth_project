import "package:flutter/material.dart";

import '../style/style.dart';

final kTextFieldDecoration = InputDecoration(
  hintText: "Enter your ",
  hintStyle: const TextStyle(
    color: AppColors.subColor,
    fontSize: 12,
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.subColor,
      )),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.error,
      )),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 1,
        color: AppColors.primaryColor,
      )),
);
