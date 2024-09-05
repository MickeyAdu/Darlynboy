import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Us",
              style: textTheme.bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: 10.h,
            ),
            const CustomTextField(
              label: "Name",
              hintText: "Enter your name",
            ),
            SizedBox(
              height: 20.h,
            ),
            const CustomTextField(
              label: "Email",
              hintText: "Enter your email",
            ),
            SizedBox(
              height: 20.h,
            ),
            TextField(
              minLines: 7,
              maxLines: null,
              decoration: InputDecoration(
                label: const Text("Description"),
                alignLabelWithHint: true,
                labelStyle: textTheme.bodyMedium!.copyWith(fontSize: 20),
                filled: true,
                fillColor: Colors.grey.shade600,
                hintText: "Descreibe your issue here",
                contentPadding: EdgeInsets.all(16.w),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(mediaQuery.width, 45.h),
                  backgroundColor: KColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Submit",
                  style: textTheme.bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ))
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
  });
  final String label;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: textTheme.bodyMedium!.copyWith(
            fontSize: 20, color: Theme.of(context).colorScheme.primary),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        hintText: hintText,
        contentPadding: EdgeInsets.all(16.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
