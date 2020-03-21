library color;

import 'package:flutter/material.dart';

class ColorPalettes{

  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Color(0xff16161C);
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Color(0xffD73831);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Color(0xff212121);
  static Color badgeColor = Colors.red;
  static Color orange = Colors.orange;
  static Color green = Colors.green;

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'IBMPlexSans',
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    dividerColor: darkBG,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 10,
      textTheme: TextTheme(
        title: TextStyle(
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
      elevation: 10,
      color: darkPrimary,
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

}