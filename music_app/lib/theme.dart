import 'package:flutter/material.dart';

class AppTheme extends Theme {
  static const Color primaryColor = Color(0xFF1E1E1E);
  static const Color secondaryColor = Color(0xFF2A2A2A);
  static const Color accentColor = Color(0xFF007ACC);
  static const Color textColor = Colors.white;
  static const Color backgroundColor = Colors.black;

  const AppTheme({super.key, required super.data, required super.child});

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      secondaryHeaderColor: secondaryColor,
      textTheme: TextTheme(
        titleLarge: TextStyle(color: textColor),
        titleMedium: TextStyle(color: textColor),
        labelMedium: TextStyle(color: textColor),
        labelSmall: TextStyle(color: textColor),
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}
