import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/maki_icons.dart';

class CustomFuelContainer extends StatefulWidget {
  const CustomFuelContainer(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      required this.iconColor});

  final String text;
  final Color color;
  final Color textColor;
  final Color iconColor;

  @override
  State<CustomFuelContainer> createState() => _CustomFuelContainerState();
}

class _CustomFuelContainerState extends State<CustomFuelContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.w),
      height: 110.h,
      width: 75.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.r),
            bottom: Radius.circular(40.r),
          ),
          color: widget.color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Maki.fuel,
            size: 45.sp,
            color: widget.iconColor,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: widget.textColor),
            ),
          )
        ],
      ),
    );
  }
}
