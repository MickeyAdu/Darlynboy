import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get getTheme {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  final darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.dark(
          surface: Colors.black,
          primary: Colors.white,
          secondary: Colors.grey[50]!,
          tertiary: Colors.black54));

  final lightTheme = ThemeData(
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
        secondary: Colors.grey[50]!,
        tertiary: Colors.white,
      ));
}
