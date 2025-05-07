import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFFFFFFF), // Main background: white or off-white
    primary: Color(0xFF1E1E1E), // Dark text or header color
    secondary: Color(0xFF6B6B5E), // Softer gray for subtext or tabs
    tertiary: Color(0xFFEAEAD4), // Light beige for highlights or cards
  ),
);
