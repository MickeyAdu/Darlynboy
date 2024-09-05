import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedContainer extends StatefulWidget {
  final String question;
  final String answer;

  const CustomAnimatedContainer({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  State<CustomAnimatedContainer> createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // animation duration
      padding: EdgeInsets.all(10.w),
      width: mediaQuery.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          width: 1.w,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.question,
                  style: textTheme.bodyMedium!.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.primary),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isTapped = !isTapped;
                    });
                  },
                  icon: Icon(
                    isTapped
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    size: 25.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isTapped)
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
              child: Text(
                widget.answer,
                style: textTheme.bodySmall!.copyWith(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
