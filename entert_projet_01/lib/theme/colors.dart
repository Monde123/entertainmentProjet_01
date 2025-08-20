// theme/colors.dart
import 'package:flutter/material.dart';

Color primaryColor = Color(0xFF2d77d1);
Color secondaryColor = Color(0xFF203d5e);
Color textColor = Color(0xFF001132);
Color backgroundColor = Color(0xffF0F4F7);
TextStyle style(double size,int weight) => TextStyle(
  color: textColor,
  fontSize: size,
  fontWeight: weight==1 ? FontWeight.w400: weight==2? FontWeight.normal :FontWeight.bold
);
