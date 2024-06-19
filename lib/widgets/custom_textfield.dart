import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validate,
  });
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: textTheme.bodySmall,
        contentPadding: EdgeInsets.all(10.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: KColors.primaryBlack, width: 1.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: KColors.primaryBlack, width: 1.5.w),
        ),
      ),
    );
  }
}
