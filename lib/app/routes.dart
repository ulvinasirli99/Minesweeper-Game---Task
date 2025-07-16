import 'package:flutter/material.dart';

class AppRoute {

  // To navigate any screen by Navigator...
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  // To pop screen. That means get back to previous screen....
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
