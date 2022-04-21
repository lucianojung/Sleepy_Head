import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF67BCB3);
Color secondaryColor = const Color(0xFF67BCB3);
Color lightBackgroundColor = const Color(0xF0F1F1F1);
Color darkBackgroundColor = const Color(0xFF262626);

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