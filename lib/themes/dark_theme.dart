import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.dark(
      surface: Colors.black,
      primary: Colors.white,
      secondary: Colors.grey[50]!,
    ));
