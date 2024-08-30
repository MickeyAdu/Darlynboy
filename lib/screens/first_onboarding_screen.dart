import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:mic_fuel/screens/second_onboarding_screen.dart';
import 'package:mic_fuel/themes/colors.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FirstOnboardingScreen extends StatefulWidget {
  const FirstOnboardingScreen({super.key});

  @override
  State<FirstOnboardingScreen> createState() => _FirstOnboardingScreenState();
}

class _FirstOnboardingScreenState extends State<FirstOnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
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
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: KColors.primaryOrange,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    topRight: Radius.circular(5.r),
                    bottomLeft: Radius.circular(5.r),
                    bottomRight: Radius.circular(5.r),
                  ),
                ),
                child: Icon(
                  MdiIcons.fuel,
                  color: Theme.of(context).colorScheme.primary,
                  size: 100.sp,
                ),
              ),
              ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          KColors.primaryOrange,
                          Color.fromARGB(255, 245, 221, 11),
                          Color.fromARGB(255, 245, 221, 11),
                          KColors.primaryOrange,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ).createShader(bounds),
                  child: Text(
                    "Fuel Me",
                    style: textTheme.bodyLarge
                        ?.copyWith(color: KColors.primaryWhite, fontSize: 50),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
