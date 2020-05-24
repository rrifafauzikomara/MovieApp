library color;

import 'package:flutter/material.dart';

class ColorPalettes{

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Color(0xff16161C);
  static Color lightAccent = Colors.deepOrange;
  static Color darkAccent = Colors.orange;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Color(0xff212121);

  static Color white = Color(0xffffffff);
  static Color grey = Colors.grey;
  static Color greyBg = Color(0xfff0f0f0);
  static Color red = Colors.red;
  static Color yellow = Colors.yellow;
  static Color green = Colors.green;
  static Color setActive = Colors.grey[500];
  static Color blueGrey = Colors.blueGrey;
  static Color black12 = Colors.black12;

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    dividerColor: darkBG,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    dividerColor: lightPrimary,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      color: darkPrimary,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  static Color getColorCircleProgress(double s) {
    Color r = ColorPalettes.red;
    if (s > 4.5 && s < 7)
      r = ColorPalettes.yellow;
    else if (s >= 7) r = ColorPalettes.green;
    return r;
  }

}