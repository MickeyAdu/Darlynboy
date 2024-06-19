import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/sign_in_screen.dart';
import 'package:mic_fuel/src/login.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/widgets/custom_password_textfield.dart';

import '../widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObsecure = true;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 45.h),
                      child: Text(
                        "Create an Account",
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, bottom: 4.h),
                                  child: Text(
                                    " First Name",
                                    style: textTheme.bodySmall,
                                  ),
                                ),
                                CustomFormTextField(
                                    label: "First Name",
                                    controller: _firstNameController,
                                    validate: (value) {
                                      return value!.isEmpty ? '' : null;
                                    }),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 4.h),
                                  child: Text(
                                    "Last Name",
                                    style: textTheme.bodySmall,
                                  ),
                                ),
                                CustomFormTextField(
                                    label: "Last Name",
                                    controller: _lastNameController,
                                    validate: (value) =>
                                        value!.isEmpty ? '' : null),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 4.h),
                                  child: Text(
                                    "Email",
                                    style: textTheme.bodySmall,
                                  ),
                                ),
                                CustomFormTextField(
                                    label: "Enter your email",
                                    controller: _emailController,
                                    validate: (value) => value!.isEmpty
                                        ? "Please enter your Email"
                                        : null),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 4.h),
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
                                      EdgeInsets.only(top: 10.h, bottom: 4.h),
                                  child: Text(
                                    "Confirm Password",
                                    style: textTheme.bodySmall,
                                  ),
                                ),
                                CustomPasswordTextField(
                                  label: "Confirm password",
                                  controller: _confirmPasswordController,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, bottom: 10.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        side: BorderSide(
                                            color: KColors.primaryBlack,
                                            width: .5.w),
                                      ),
                                      backgroundColor: KColors.secondaryGreen,
                                      fixedSize: Size(mediaQuery.width, 45),
                                    ),
                                    onPressed: () {
                                      _registerUser();
                                    },
                                    child: Text(
                                      "Create an Account",
                                      style: textTheme.bodySmall!.copyWith(
                                          color: KColors.primaryWhite,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: textTheme.bodyMedium!.copyWith(
                                          color: KColors.primaryGreen,
                                          fontSize: 16),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LogIn()));
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: textTheme.bodyMedium!.copyWith(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 16,
                                            color: KColors.primaryGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 40.h, left: 16.w),
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

  void _registerUser() async {
    // Ensure all inputs are validated before proceeding
    if (!_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'Please fill in all fields correctly and agree to the terms.'),
        ),
      );
      return;
    }

    // Consolidate error checks to simplify state updates
    String errorMessage = _validateInputs();
    if (errorMessage.isNotEmpty) {
      _showError(errorMessage);
      return;
    }

    setState(() => _Loading = true);

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
      });

      _showRegistrationSuccessful();
    } catch (e) {
      _showError('Failed to register: ${e.toString()}');
    } finally {
      setState(() => _Loading = false);
    }
  }

  String _validateInputs() {
    if (_firstNameController.text.trim().isEmpty) return 'Username is empty.';
    if (!_isEmailValid(_emailController.text.trim()))
      return 'Invalid Email format.';
    if (_phoneController.text.trim().length != 10)
      return 'Phone number must be 10 digits.';
    if (!_isPasswordValid(_passwordController.text.trim()))
      return 'Invalid password format.';
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim())
      return 'Passwords do not match.';
    return '';
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'^(?=.*[A-Z]+)["\w#$%&()*+,\-!./:;<=>?@\[^\]_`{|}~]+$')
            .hasMatch(password) &&
        RegExp(r'^(?=.*\d+)["\w#$%&()*!+,\-./:;<=>?@\[^\]_`{|}~]+$')
            .hasMatch(password) &&
        RegExp(r'^(?=.*["#$%&()*+,\-./:;<=>?@\[^\]_!`{|}~])["\w!#$%&()*+,\-./:;<=>?@\[^\]_`{|}~]+$')
            .hasMatch(password);
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showRegistrationSuccessful() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registration Successful'),
        content: Text('Your account has been successfully created!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignInScreen(
                          // label: 'password',
                          )));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

compareRegex(String input, String pattern) {
  RegExp reg = RegExp(pattern);
  return reg.hasMatch(input);
}
