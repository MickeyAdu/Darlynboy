import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 21, fontFamily: 'Poppins')),
    colorScheme: ColorScheme.light(
      surface: Colors.blue,
      primary: Colors.black,
      secondary: Colors.grey[50]!,
      tertiary: Colors.white,
    ));
