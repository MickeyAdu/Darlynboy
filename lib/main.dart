import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/first_onboarding_screen.dart';
import 'themes/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return ScreenUtilInit(
          designSize: const Size(360, 717),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getTheme,
              home: const FirstOnboardingScreen(),
            );
          },
        );
      },
    );
  }
}
