// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); 
  
  static const primaryColor = Colors.blueAccent;
  static const grey = Colors.grey;
  static const white = Colors.white;
  static const black = Colors.black;
  static const error = Colors.redAccent;
  static const success = Colors.green;
  static const darkGrey = Color(0xffE7EBED);
  static const List<MaterialAccentColor> accents = <MaterialAccentColor>[
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.indigoAccent,
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
  ];
  static List<Color> indicatorColors = [
    Colors.red.shade900,
    Colors.red.shade700,
    Colors.red,
    Colors.yellow.shade700,
    Colors.yellow,
    Colors.yellow.shade400,
    Colors.yellow.shade300,
    Colors.green,
    Colors.green.shade700,
    Colors.green.shade900
  ];

}
