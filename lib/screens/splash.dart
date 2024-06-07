import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:yolo/screens/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: Colors.black,
        splash: Center(
          child: Image.asset(width: 200, height: 200, "assets/images/sp.jpeg"),
        ),
        nextScreen: const LoginPage());
  }
}
