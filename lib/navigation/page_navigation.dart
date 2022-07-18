import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNavigation {
  //FOR PUSH ONLY
  void push(BuildContext context, Widget newPage) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => newPage));
  }

  //FOR PUSHREPLACEMENT
  void replace(BuildContext context, Widget newPage) {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => newPage));
  }

//FOR PUSH AND REMOVE LAYER
  void remove(BuildContext context, Widget newPage) {
    Navigator.pushAndRemoveUntil(context,
        CupertinoPageRoute(builder: (context) => newPage), (route) => false);
  }
}
