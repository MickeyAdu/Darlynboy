import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/src/startPage.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/widgets/custom_elevated_button.dart';

class FourthOnboardingScreen extends StatelessWidget {
  const FourthOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [KColors.gainsBoro, KColors.philliphineGrey])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
            child: Column(
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
                    "assets/service.png",
                    height: 250.h,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "24/7",
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      "Service",
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Text(
                  "You're our Top prority",
                  style: textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h, top: 100.h),
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: 2,
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
                CustomElevatedButton(
                  label: "GET STARTED",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartPage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
