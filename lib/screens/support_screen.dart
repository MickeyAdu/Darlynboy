import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/contact_us_screen.dart';
import 'package:mic_fuel/screens/faqs_screen.dart';
import 'package:mic_fuel/screens/troubleshoot.dart';

import '../themes/colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              elevation: 5,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 25.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              title: Text(
                "Support",
                style: textTheme.bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "FAQs",
                    height: 50.h,
                  ),
                  Tab(
                    text: "Troubleshoot",
                    height: 50.h,
                  ),
                  Tab(text: "Contact Us", height: 50.h),
                ],
                labelStyle: textTheme.bodyMedium!.copyWith(),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Theme.of(context).colorScheme.primary,
              ),
              toolbarHeight: 45,
            ),
            body: const TabBarView(
              children: [
                FAQsScreen(),
                TroubleshootScreen(),
                ContactUsScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
