import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:yolo/widgets/box_image.dart';
import '../commons/utils/firebase_methods.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_elevated_button.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  signUpUser(BuildContext ctx) async {
    if (passwordController.text.trim() !=
        confirmpasswordController.text.trim()) {
      Fluttertoast.showToast(msg: 'Password is not equal');
      return;
    }

    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmpasswordController.text.trim().isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });
        final res = await Authentication().signUp(
          fullName: nameController.text.trim(),
          // badgeNumber: badgeNumberController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        setState(() {
          isLoading = false;
        });
        if (res == 'Successful') {
          setState(() {
            emailController.text = "";
            passwordController.text = "";
            confirmpasswordController.text = "";
            // badgeNumberController.text = "";
            nameController.text = "";
          });

          Fluttertoast.showToast(
              msg: res, backgroundColor: Colors.grey, textColor: Colors.white);
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        } else {
          Fluttertoast.showToast(msg: 'Error couldn\'t sign up');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Please provide all fields");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();

    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BoxImageDecoration(
          imageUrl: "assets/images/car_my.jpg",
        ),
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
          ),
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50), // Space from top
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Sign up to get started!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomTextField(
                      icon: const Icon(Icons.person),
                      controller: nameController,
                      hintText: 'Name',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      icon: const Icon(Icons.email),
                      controller: emailController,
                      hintText: 'Email',
                    ),

                    // const SizedBox(height: 20),
                    // CustomTextField(
                    //   icon: const Icon(Icons.email),
                    //   controller: badgeNumberController,
                    //   hintText: 'Badge Number',
                    // ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      icon: const Icon(Icons.lock),
                      controller: passwordController,
                      isPass: true,
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      icon: const Icon(Icons.lock),
                      controller: confirmpasswordController,
                      isPass: true,
                      hintText: 'Confirm Password',
                    ),
                    const SizedBox(height: 40),
                    CustomElevatedButton(
                      onPressed: isLoading
                          ? () {}
                          : () {
                              // Add sign-up logic here
                              signUpUser(context);
                            },
                      label: isLoading ? "....." : 'Sign Up',
                      width: double.infinity,
                      height: 50,
                      backgroundColor: Colors.teal,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?',
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
