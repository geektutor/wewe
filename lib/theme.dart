import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color geekColor = Color(0xFFFFFFFF);
Color geekBlackColor = Color(0xFF00C35E);

ThemeData lightTheme = ThemeData.light();
ThemeData darkThemeReal = ThemeData.dark();
TextTheme _textTheme = TextTheme(
    bodyText1: GoogleFonts.nunito(
        textStyle: TextStyle(
  fontSize: 22,
)));

ThemeData darkTheme = darkThemeReal.copyWith(
    buttonColor: geekBlackColor,
    primaryIconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
        bodyText1: _textTheme.bodyText1.copyWith(color: Colors.white)));

ThemeData lighterTheme = lightTheme.copyWith(
    primaryColor: Color(0xFFF1F1F1),
    primaryIconTheme: IconThemeData(
      color: Colors.black,
    ),
    canvasColor: Color(0xFF00C35E),
    buttonColor: geekColor,
    textTheme: TextTheme(
        bodyText1: _textTheme.bodyText1.copyWith(color: Colors.black)));

ThemeData pinkTheme = lightTheme.copyWith(
  primaryColor: Color(0xFFF1F1F1),
  scaffoldBackgroundColor: Color(0xFFFAF8F0),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0xFF24737c),
    backgroundColor: Color(0xFFA6E0DE),
  ),
  textTheme: TextTheme(
    body1: TextStyle(
      color: Colors.black87,
    ),
  ),
);

ThemeData halloweenTheme = lightTheme.copyWith(
  primaryColor: Color(0xFF55705A),
  scaffoldBackgroundColor: Color(0xFFE48873),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFea8e71),
    backgroundColor: Color(0xFF2b2119),
  ),
);

ThemeData darkBlueTheme = ThemeData.dark().copyWith(
  primaryColor: Color(0xFF1E1E2C),
  scaffoldBackgroundColor: Color(0xFF2D2D44),
  textTheme: TextTheme(
    body1: TextStyle(
      color: Color(0xFF33E1Ed),
    ),
  ),
);
