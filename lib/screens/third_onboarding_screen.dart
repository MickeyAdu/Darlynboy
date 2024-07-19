import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/fourth_onboarding_screen.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/src/login.dart';

class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: KColors.grey,
        body: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 80.h, top: 30.h),
                child: Image.asset(
                  "assets/delivery.png",
                  height: 300.h,
                  width: mediaQuery.width,
                ),
              ),
              Text(
                "Fuel your vechicle",
                style: textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Text(
                "Anytime, Anywhere",
                style: textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: KColors.primaryOrange),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h, top: 145.h),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: 1,
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
                                builder: (context) =>
                                    const FourthOnboardingScreen()));
                      },
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        color: KColors.primaryWhite,
                        size: 25.sp,
                      ),
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
