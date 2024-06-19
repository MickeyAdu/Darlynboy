import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/fourth_onboarding_screen.dart';
import 'package:mic_fuel/themes/colors.dart';

class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [
              KColors.gainsBoro,
              KColors.philliphineGrey,
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 25.sp,
                      color: KColors.primaryBlack.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.h, top: 70.h),
                child: Image.asset(
                  "assets/time.png",
                  height: 250.h,
                ),
              ),
              Text(
                "Fuel your vechicle",
                style: textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Text(
                "Anytime, Anywhere",
                style:
                    textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 105.h, top: 70.h),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: 1,
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FourthOnboardingScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
