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
        surface: Colors.grey[300]!,
        primary: Colors.black,
        secondary: Colors.grey[50]!));
