// viewModel/theme_provider.dart
import 'package:flutter/material.dart';


TextStyle style(double size, int weight, Color textColor) => TextStyle(
  color: textColor,
  fontSize: size,
  fontWeight:
      weight == 1
          ? FontWeight.w400
          : weight == 2
          ? FontWeight.normal
          : FontWeight.bold,
);

class ChangeColor with ChangeNotifier {
  final Color _primaryColorDark = const Color(0xFF4D9FFF);
  final Color _secondaryColorDark = const Color(0xFF0D253F);
  final Color _textColorDark = const Color(0xFFE6EEF5);
  final Color _backgroundColorDark = const Color(0xFF121212);
  final Color _primaryColorLight = Color(0xFF2d77d1);
  final Color _secondaryColorLight = Color(0xFF203d5e);
  final Color _textColorLight = Color(0xFF001132);
  final Color _backgroundColorLight = Color(0xffF0F4F7);
  bool _isDark = false;
  Color get primaryColor =>
      _isDark == true ? _primaryColorDark : _primaryColorLight;
  Color get secodaryColor =>
      _isDark == true ? _secondaryColorDark : _secondaryColorLight;
  Color get textColor => isDark == true ? _textColorDark : _textColorLight;
  Color get background =>
      _isDark == true ? _backgroundColorDark : _backgroundColorLight;
  bool get isDark => _isDark;
    void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners(); // notifie les widgets consommateurs
  }
}