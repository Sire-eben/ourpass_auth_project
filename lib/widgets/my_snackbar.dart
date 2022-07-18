import 'package:flutter/material.dart';

SnackBar mySnackbar(String msg) => SnackBar(
      content: Text(msg),
      elevation: 1,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.redAccent,
    );
