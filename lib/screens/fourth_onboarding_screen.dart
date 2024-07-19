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
      child: Scaffold(
        // backgroundColor: KColors.grey,
        body: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
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
                      Icons.arrow_back_outlined,
                      size: 30.sp,
                      color: KColors.primaryBlack,
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 18.h, top: 8.h),
                  child: Image.asset('assets/Service.png')),
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "24/7",
                      style: textTheme.bodyLarge!
                          .copyWith(color: KColors.primaryOrange),
                    ),
                    Text(
                      " Service",
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Text(
                "You're our Top prority",
                style: textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h, top: 80.h),
                child: DotsIndicator(
                  dotsCount: 3,
                  position: 2,
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
    );
  }
}
