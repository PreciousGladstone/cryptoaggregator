import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF121212),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF3399FF), // slightly lighter blue for dark mode
    secondary: Color(0xFFADB5BD), // lighter grey for contrast
    onPrimary: Color(0xFF000000), // text/icons on primary
    onSecondary: Color(0xFF000000), // text/icons on secondary
    surface: Color(0xFF1E1E1E), // cards, containers
    onSurface: Color(0xFFFFFFFF), // text on surfaces
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Circular std',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Circular std',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1C1C1C),
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
