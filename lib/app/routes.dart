import 'package:flutter/material.dart';

class AppRoute {
  static void push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void pop(BuildContext context){
    Navigator.of(context).pop();
  }
}
