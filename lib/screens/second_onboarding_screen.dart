import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/sign_in_screen.dart';
import 'package:mic_fuel/screens/third_onboarding_screen.dart';
import 'package:mic_fuel/src/startPage.dart';
import 'package:mic_fuel/themes/colors.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 8.w, right: 8.w),
          child: Column(
            children: [
              Text(
                "Welcome to",
                style: textTheme.bodyLarge!.copyWith(
                    fontSize: 25, color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                "Fuel Me",
                style: textTheme.bodyLarge!.copyWith(
                  fontSize: 30,
                  color: KColors.primaryOrange,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
                child: Image.asset("assets/second.png"),
              ),
              Text(
                "Connect with nearby",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                "Fuel Stations",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: KColors.primaryOrange),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h, top: 40.h),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: 0,
                  decorator: DotsDecorator(
                    color: KColors.primaryGrey,
                    activeColor: KColors.primaryOrange,
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const CircleBorder(
                        side: BorderSide.none,
                      ),
                      fixedSize: Size(75.w, 50.h),
                      backgroundColor: KColors.primaryOrange,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartPage()));
                    },
                    child: Text(
                      "Skip",
                      style: textTheme.bodySmall!
                          .copyWith(color: KColors.primaryWhite),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const CircleBorder(
                          side: BorderSide.none,
                        ),
                        fixedSize: Size(75.w, 50.h),
                        backgroundColor: KColors.primaryOrange,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ThirdOnboardingScreen()));
                      },
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        color: KColors.primaryWhite,
                        size: 25.sp,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
