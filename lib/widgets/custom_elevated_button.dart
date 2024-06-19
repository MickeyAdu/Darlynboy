import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onTap,
  });
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.sizeOf(context);
    var textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: KColors.primaryBlack, width: .5.w),
        ),
        backgroundColor: KColors.primaryBlue,
        fixedSize: Size(mediaQuery.width, 45),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: textTheme.bodySmall!
            .copyWith(color: KColors.primaryWhite, fontSize: 15),
      ),
    );
  }
}
