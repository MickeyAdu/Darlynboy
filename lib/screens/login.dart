import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yolo/commons/utils/firebase_methods.dart';
import 'package:yolo/screens/home_page.dart';
import 'package:yolo/screens/sign_up.dart';
import 'package:yolo/widgets/box_image.dart';
import 'package:yolo/widgets/custom_elevated_button.dart';
import 'package:yolo/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final Authentication authentication = Authentication();
  login({required BuildContext ctx}) async {
    if (passwordController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });
        final response = await authentication.loginUser(
            passwordController.text.trim(), emailController.text.trim());
        // print(response);
        if (response) {
          Navigator.push(
              ctx, MaterialPageRoute(builder: (ctx) => const HomePage()));
        }
        setState(() {
          isLoading = false;
        });
      } catch (err) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill all feilds");
    }
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
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomTextField(
                      icon: const Icon(Icons.email),
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      icon: const Icon(Icons.lock),
                      controller: passwordController,
                      hintText: 'Password',
                      isPass: true,
                    ),
                    const SizedBox(height: 40),
                    CustomElevatedButton(
                      onPressed: () => login(ctx: context),
                      // Add login logic here

                      label: isLoading ? "Loading....." : 'Login',
                      width: double.infinity,
                      height: 50,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account?",
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
                            );
                          },
                          child: Text(
                            'Sign Up',
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
        )
      ],
    );
  }
}
