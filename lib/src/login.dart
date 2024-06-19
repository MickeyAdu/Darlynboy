import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/src/WorkerHomeScreen.dart';
import 'package:mic_fuel/src/forget_pass.dart';
import 'package:mic_fuel/src/home.dart';
import 'package:mic_fuel/src/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/widgets/custom_password_textfield.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_textfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
  String _errorMessageE = "";
  String _errorMessageP = "";

  bool _errorState = false;
  bool _errorStateE = false;
  bool _errorStateP = false;

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
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [KColors.primaryOrange, KColors.primaryWhite])),
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.0.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.amber),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.amber),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      labelText: 'Email',
                                      errorText:
                                          _errorStateE ? _errorMessageE : null,
                                      errorStyle: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 10.0
                                        .h), // Add spacing between containers

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    obscureText: _obscureText,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.amber),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.amber),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      labelText: 'Password',
                                      errorText:
                                          _errorStateP ? _errorMessageP : null,
                                      errorStyle: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 20.h, bottom: 10.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // gradient: LinearGradient(
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //     colors: [
                                        //   KColors.primaryOrange,
                                        //   KColors.primaryOrange,
                                        //   KColors.primaryWhite
                                        // ]),
                                        ),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize:
                                                Size(mediaQuery.width, 45),
                                            backgroundColor:
                                                KColors.secondaryOrange,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8.0.r)),
                                            side: BorderSide.none,
                                            textStyle: const TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                            )),
                                        child: const Text(" Sign In"),
                                        onPressed: () => _validate(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0.h),
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
                                SizedBox(height: 12.0.h),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: KColors.secondaryOrange,
                                            width: 1.5.w),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
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
                                        color: KColors.primaryOrange
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
                                          color: KColors.primaryOrange
                                              .withOpacity(.8),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 35.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/apple.jpeg'),
                                            ),
                                          ),
                                        ),
                                        // onTap: federateGoogleLogin,
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/google.jpeg'),
                                            ),
                                          ),
                                        ),
                                        onTap: federateGoogleLogin,
                                      ),
                                    ],
                                  ),
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
                    _Loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void federateGoogleLogin() async {
    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    signInWithGoogle().then((value) async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details fetched successfully')),
      );
      if (value.user != null) {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        User? user = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'first_name': value.user!.displayName!.split(' ')[0],
          'last_name': value.user!.displayName!.split(' ').length == 2
              ? value.user!.displayName!.split(' ')[1]
              : '',
          'email': value.user!.email,
          'phone': value.user!.phoneNumber,
          'role': 'user',
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No User is found')),
        );
      }
    }).catchError((err) {
      print("Sign-in error: $err");
    });
  }

  //login here
  void _validate() async {
    // Clear any previous error message and ensure loading indicator is off initially
    setState(() {
      _errorMessage = "";
      _Loading = true;
      _errorState = false;
    });
    //username validation
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _Loading = false;
        _errorMessageE = 'Email is empty.';
        _errorStateE = true;
      });
      if (_passwordController.text.trim().isEmpty) {
        setState(() {
          _Loading = false;
          _errorMessageP = 'Password is empty.';
          _errorStateP = true;
        });
      }
      return;
      //return early as an error has been caught
    } else {
      setState(() {
        _Loading = true;
        _errorMessage = '';
        _errorState = false;
      });
    }
    String _getFirebaseErrorMessage(String errorCode) {
      switch (errorCode) {
        case 'user-not-found':
          return "No user found for that email.";
        case 'wrong-password':
          return "Wrong password provided for that user.";
        default:
          return "An error occurred: $errorCode";
      }
    }

    if (_formKey.currentState!.validate()) {
      // Simulate a quick loading/checking process
      await Future.delayed(const Duration(seconds: 1));

      // Proceed with Firebase authentication
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        if (credential.user != null) {
          final FirebaseAuth _auth = FirebaseAuth.instance;
          User? user = _auth.currentUser;
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection('users')
              .doc(user!.uid)
              .get();
          if (userData['role'] == 'user') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const HomeWorker(), // Route to worker Home Screen
                ));
          }
        }
      } on FirebaseAuthException catch (e) {
        // Set specific error messages based on Firebase error codes
        _errorMessage = _getFirebaseErrorMessage(e.code);
        _errorState = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email badly formatted',
            ),
            backgroundColor: Colors.black26,
          ),
        );
      } finally {
        // Ensure loading is turned off after processing
        setState(() {
          _Loading = false;
        });
      }
    } else {
      // Handle form not valid
      setState(() {
        _Loading = false;
        _errorMessage =
            "Please check your inputs."; // Generic message for form validation failure
        _errorState = true;
      });
    }
  }
}
