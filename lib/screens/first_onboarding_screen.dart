import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mic_fuel/screens/second_onboarding_screen.dart';
import 'package:mic_fuel/themes/colors.dart';

class FirstOnboardingScreen extends StatefulWidget {
  const FirstOnboardingScreen({super.key});

  @override
  State<FirstOnboardingScreen> createState() => _FirstOnboardingScreenState();
}

class _FirstOnboardingScreenState extends State<FirstOnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondOnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [KColors.primaryOrange, KColors.primaryYellow])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.fuel,
                  color: KColors.primaryWhite,
                  size: 100.sp,
                ),
                Text(
                  "Fuel Me",
                  style: textTheme.bodyLarge!
                      .copyWith(color: KColors.primaryWhite, fontSize: 50),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
