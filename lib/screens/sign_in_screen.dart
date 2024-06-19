import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/sign_up_screen.dart';
import 'package:mic_fuel/src/signup.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/widgets/custom_password_textfield.dart';

import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObsecure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  String _errorTextUsername = '';
  String _errorTextPassword = '';
  bool _isErrorUsername = false;
  bool _isErrorPassword = false;
  bool _obscureText = true;
  bool _Loading = false;
  String _errorMessage = "";
  bool _errorState = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 220.h,
                width: mediaQuery.width,
                decoration: const BoxDecoration(
                  color: KColors.secondaryGreen,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70.h),
                      child: Text(
                        "Fuel Me",
                        style: textTheme.bodyLarge!.copyWith(
                            color: KColors.primaryWhite, fontSize: 50),
                      ),
                    ),
                    Text(
                      "Future of Convenient",
                      style: textTheme.bodyMedium!
                          .copyWith(color: KColors.primaryWhite),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: Text(
                        "Refueling",
                        style: textTheme.bodyMedium!
                            .copyWith(color: KColors.primaryWhite),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: KColors.primaryWhite,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 30.h, bottom: 4.h),
                                child: Text(
                                  "Email",
                                  style: textTheme.bodySmall,
                                ),
                              ),
                              CustomFormTextField(
                                  label: "Enter your Email",
                                  controller: _emailController,
                                  validate: (value) => value!.isEmpty
                                      ? "Please enter your Email"
                                      : null),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 18.h, bottom: 4.h),
                                child: Text(
                                  "Password",
                                  style: textTheme.bodySmall,
                                ),
                              ),
                              CustomPasswordTextField(
                                label: "Enter password",
                                controller: _passwordController,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 20.h, bottom: 10.h),
                                child: CustomElevatedButton(
                                  onTap: () {},
                                  label: "Sign In",
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: KColors.primaryBlack,
                                      height: 5.h,
                                    ),
                                  ),
                                  Text(
                                    "  or  ",
                                    style: textTheme.bodySmall,
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: KColors.primaryBlack,
                                      height: 5.h,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: KColors.secondaryGreen,
                                          width: 1.5.w),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  backgroundColor: KColors.primaryWhite,
                                  fixedSize: Size(mediaQuery.width, 45),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()));
                                },
                                child: Text(
                                  "New to Fuel Me? Sign Up",
                                  style: textTheme.bodySmall!.copyWith(
                                      color: KColors.secondaryGreen
                                          .withOpacity(.9),
                                      fontSize: 15),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot Password?",
                                      style: textTheme.bodySmall!.copyWith(
                                        color: KColors.secondaryGreen
                                            .withOpacity(.8),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40.h, left: 16.w),
                                child: Text(
                                  "By creating an account, you accept Fuel Me's Terms",
                                  style: textTheme.bodySmall!
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "of Service and Privacy Policy",
                                    style: textTheme.bodySmall!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
