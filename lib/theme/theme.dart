import "package:flutter/material.dart";

/// Theme data for the project
ThemeData themeData = ThemeData(
  primarySwatch: Colors.red,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 14,
          letterSpacing: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white70,
    foregroundColor: Colors.black87,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.black87,
      fontSize: 18,
    ),
    
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.red,
    textTheme: ButtonTextTheme.primary,
  ),
);
