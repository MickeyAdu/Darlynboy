import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    required this.label,
    required this.controller,
  });
  final String label;
  final TextEditingController? controller;
  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isObsecure = true;
  bool _isAgreed = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _Loading = false;
  String _errorTextUsername = '';
  String _errorTextPassword = '';
  String _errorTextConfirmPassword = '';
  String _errorTextEmail = '';
  String _errorTextPhone = '';
  bool _isErrorUsername = false;
  bool isErrorPassword = false;
  bool isErrorConfirmPassword = false;

  bool isErrorEmail = false;
  bool isErrorPhone = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextField(
      obscureText: isObsecure,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        hintText: "Enter your password",
        hintStyle: textTheme.bodySmall,
        errorText: isErrorPassword ? _errorTextPassword : null,
        errorStyle: const TextStyle(color: Colors.red),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isObsecure = !isObsecure;
            });
          },
          child: Icon(
            (isObsecure)
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
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
