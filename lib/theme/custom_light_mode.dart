import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: Color(0xFFF8F9FA),
    shadowColor: Color(0xFFDFE2E4),
    
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF0063F5),
      secondary: Color(0xFF6C757D),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF212529),
      
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Circular std',
        fontSize: 24,
        fontWeight: FontWeight.w500
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Circular std',
        fontSize: 16,
        fontWeight: FontWeight.w500
      ),
    )
);

