import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/themes/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 25.sp,
                color: Theme.of(context).colorScheme.primary,
              )),
          title: Text(
            "About",
            style: textTheme.bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r),
                        image: DecorationImage(
                            image: AssetImage('assets/muriel.png'))),
                    height: 190.h,
                    width: mediaQuery.width,
                    //pass logo here
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Our Mission",
                  style: textTheme.bodyLarge!.copyWith(color: Colors.orange),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We aim to make life easier for everybody, starting with fuel. We believe in providing quality services that are convienent and reliable for our users.",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "What we offer",
                  style: textTheme.bodyLarge!.copyWith(color: Colors.orange),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "We deliver fuel; petrol, deisel or gas directly to you. Our team iis dedicated to ensuring a seamless delivery process all in our user-centric application",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "What people say about us",
                  style: textTheme.bodyLarge!.copyWith(color: Colors.orange),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Yuri",
                  style: textTheme.bodyMedium!
                      .copyWith(fontSize: 20, color: Colors.blueAccent),
                ),
                Text(
                  "04/06/2022",
                  style: textTheme.bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 22.sp,
                    );
                  }),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "The service was fast, easy and efficient. Honestky, I like the whole idea of not stopping to buy fuel",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Mickey",
                  style: textTheme.bodyMedium!
                      .copyWith(fontSize: 20, color: Colors.blueAccent),
                ),
                Text(
                  "05/07/2022",
                  style: textTheme.bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 22.sp,
                    );
                  }),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "I don't have time to go to the fuel station. This service maked my life so much easeir",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "DarlynBoy",
                  style: textTheme.bodyMedium!
                      .copyWith(fontSize: 20, color: Colors.blueAccent),
                ),
                Text(
                  "12/03/2022",
                  style: textTheme.bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 22.sp,
                    );
                  }),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "I've used this service twice now, and both times it's ben quick and convenient.\nI'm a fan ",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 40.h,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/yuri.jpg'),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/mickey.jpg'),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/darlynboy.jpg'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Contact Us",
                  style: textTheme.bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListTile(
                  leading: Container(
                    height: 70.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      size: 30.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    "Email",
                    style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  subtitle: Text(
                    "fuelme@google.com",
                    style: textTheme.bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ListTile(
                  leading: Container(
                    height: 70.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.phone_outlined,
                      size: 30.sp,
                      // color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text(
                    "Phone",
                    style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  subtitle: Text(
                    "+233558754870",
                    style: textTheme.bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  dense: true,
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        fixedSize: Size(mediaQuery.width, 45.h),
                        backgroundColor: KColors.primaryOrange),
                    onPressed: () {},
                    child: Text(
                      "Get Started",
                      style: textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    )),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
