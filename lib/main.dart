import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/first_onboarding_screen.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/themes/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart'; // Added import for provider

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("isDark") ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(isDark: themeBool),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
