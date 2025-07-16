import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Menu Screen
  static const TextStyle menuTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // Game Board
  static TextStyle getTileNumber(int number) => TextStyle(
    color: AppColors.getNumberColor(number),
    fontWeight: FontWeight.bold,
  );
}
