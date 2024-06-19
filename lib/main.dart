import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/first_onboarding_screen.dart';
import 'package:mic_fuel/screens/sign_up_screen.dart';
import 'package:mic_fuel/themes/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 717),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: KColors.primaryWhite,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: KColors.primaryBlack,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
            bodyMedium: TextStyle(
              color: KColors.primaryBlack,
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
                color: KColors.primaryBlack,
                fontFamily: "Poppins",
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: KColors.primaryBlack,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: KColors.primaryWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
            bodyMedium: TextStyle(
              color: KColors.primaryWhite,
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
                color: KColors.primaryWhite,
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // themeMode: ,
        home: const FirstOnboardingScreen(),
      ),
    );
  }
}
