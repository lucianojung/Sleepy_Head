import 'dart:ui';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF0f006d);
Color secondaryColor = const Color(0xFFd129f9);
Color lightBackgroundColor = const Color(0xFF3a3a3a);
Color darkBackgroundColor = const Color(0xFF0a0a0a);
MaterialColor cloudColors = const MaterialColor(0, {
  500: Color(0xFF0f006d),
  400: Color(0xFF291B80),
  300: Color(0xFF50449B),
  200: Color(0xFF8A81C4),
  100: Color(0xFFC3BDED),
  50: Color(0xFFDCD7FF),
});

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  backgroundColor: lightBackgroundColor,
  colorScheme: const ColorScheme.light()
      .copyWith(primary: primaryColor, secondary: secondaryColor, background: lightBackgroundColor),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  backgroundColor: darkBackgroundColor,
  colorScheme: const ColorScheme.light()
      .copyWith(primary: primaryColor, secondary: secondaryColor, background: darkBackgroundColor),
);

Gradient headerGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2CBFFD), Color(0xFF777BFC), Color(0xFFD129F9)]);
TextStyle headerStyle = TextStyle(fontSize: 54);
TextStyle subheaderStyle = TextStyle(color: Colors.white, fontSize: 32);
TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 24);
TextStyle textStyle18 = TextStyle(color: Colors.white, fontSize: 18);

BubbleStyle bubbleStyleSam = BubbleStyle(
  nip: BubbleNip.leftTop,
  nipWidth: 16,
  nipHeight: 16,
  color: primaryColor,
  borderColor: Colors.transparent,
  borderWidth: 1,
  elevation: 4,
  margin: BubbleEdges.only(top: 8, right: 50),
  alignment: Alignment.topLeft,
);

BubbleStyle bubbleStyleNarrator = BubbleStyle(
  nip: BubbleNip.no,
  // nipWidth: 16,
  // nipHeight: 16,
  color: primaryColor,
  borderColor: Colors.transparent,
  borderWidth: 1,
  elevation: 4,
  // margin: BubbleEdges.only(top: 8, right: 50),
  alignment: Alignment.topCenter,
);

BubbleStyle bubbleStyleUser = BubbleStyle(
  nip: BubbleNip.rightTop,
  nipWidth: 16,
  nipHeight: 16,
  color: secondaryColor,
  borderColor: Colors.transparent,
  borderWidth: 1,
  elevation: 4,
  margin: BubbleEdges.only(top: 8, left: 50),
  alignment: Alignment.topRight,
);

ButtonStyle buttonStyleUser = ButtonStyle(
  foregroundColor: MaterialStateProperty.all(secondaryColor),
  backgroundColor: MaterialStateProperty.all(secondaryColor),
  padding: MaterialStateProperty.all(EdgeInsets.all(4)),
  elevation: MaterialStateProperty.all(4),
  alignment: Alignment.topRight,
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
  ),
);
