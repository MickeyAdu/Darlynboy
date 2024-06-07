import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color labeColor;
  const CustomElevatedButton({
    super.key,
    this.labeColor = Colors.white,
    required this.onPressed,
    required this.label,
    this.width = double.infinity,
    this.height = 50,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: labeColor, fontSize: 18),
        ),
      ),
    );
  }
}
