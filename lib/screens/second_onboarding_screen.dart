import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/third_onboarding_screen.dart';
import 'package:mic_fuel/src/startPage.dart';
import 'package:mic_fuel/themes/colors.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [KColors.philliphineGrey, KColors.gainsBoro])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(top: 70.h, left: 8.w, right: 8.w),
            child: Column(
              children: [
                Text(
                  "Welcome to",
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 25,
                  ),
                ),
                Text(
                  "Fuel Me",
                  style: textTheme.bodyLarge!.copyWith(
                    fontSize: 30,
                    color: KColors.primaryBlue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.h, top: 8.h),
                  child: Image.asset(
                    "assets/first.png",
                    height: 250.h,
                  ),
                ),
                Text(
                  "Connect with nearby",
                  style: textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                Text(
                  "Fuel Stations",
                  style: textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 75.h, top: 60.h),
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: 0,
                    decorator: DotsDecorator(
                      color: KColors.daveyGrey,
                      activeColor: KColors.primaryBlue,
                      size: const Size.square(9.0),
                      activeSize: const Size(40.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StartPage()));
                      },
                      child: Text(
                        "Skip",
                        style: textTheme.bodySmall,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ThirdOnboardingScreen()));
                      },
                      child: Row(
                        children: [
                          Text(
                            "Next",
                            style: textTheme.bodySmall,
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: KColors.primaryBlack,
                            size: 25.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
