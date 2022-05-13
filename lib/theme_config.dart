import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF031024);
Color secondaryColor = const Color(0xFFBFE832);
Color lightBackgroundColor = const Color(0xFF072048);
Color darkBackgroundColor = const Color(0xFF273D4E);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  backgroundColor: lightBackgroundColor,
  colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      background: lightBackgroundColor),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  backgroundColor: darkBackgroundColor,
  colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      background: darkBackgroundColor),

);

TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);