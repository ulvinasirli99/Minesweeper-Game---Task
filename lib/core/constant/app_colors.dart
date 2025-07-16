import 'package:flutter/material.dart';

class AppColors {
  // Tile Colors
  static Color get tileUnrevealed => Colors.grey.shade400;
  static Color get tileRevealed => Colors.grey.shade200;
  static Color get tileMine => Colors.red.shade400;
  static Color get tileBorder => Colors.grey.shade700;
  static const Color tileFlag = Colors.red;

  // Number Colors
  static const Color numberOne = Colors.blue;
  static const Color numberTwo = Colors.green;
  static const Color numberThree = Colors.red;
  static const Color numberFour = Colors.purple;
  static const Color numberFive = Colors.deepOrangeAccent;
  static const Color numberSix = Colors.cyan;
  static const Color numberSeven = Colors.black;
  static const Color numberEight = Colors.grey;

  // Bomb Colors
  static const Color bombBody = Colors.black;
  static Color get bombHighlight => Colors.white.withOpacity(0.5);

  // App Bar
  static Color getAppBarColor(BuildContext context) => 
      Theme.of(context).colorScheme.inversePrimary;


  static Color getNumberColor(int number) {
    switch (number) {
      case 1:
        return AppColors.numberOne;
      case 2:
        return AppColors.numberTwo;
      case 3:
        return AppColors.numberThree;
      case 4:
        return AppColors.numberFour;
      case 5:
        return AppColors.numberFive;
      case 6:
        return AppColors.numberSix;
      case 7:
        return AppColors.numberSeven;
      case 8:
        return AppColors.numberEight;
      default:
        return AppColors.numberSeven;
    }
  }

}
