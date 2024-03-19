// ignore_for_file: avoid_print, use_build_context_synchronously, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mic_fuel/common/snackbar.dart';
import 'package:mic_fuel/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mic_fuel/src/home.dart';
import 'package:mic_fuel/src/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final Authservice _auth = Authservice();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
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
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Fuel Me',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (isLoading)
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 50)),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Welcome to fuel delivery',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          labelText: 'User Name',
                          errorText:
                              _isErrorUsername ? _errorTextUsername : null,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Email',
                          errorText: isErrorEmail ? _errorTextEmail : null,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: phoneController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Phone Number',
                          errorText: isErrorPhone ? _errorTextPhone : null,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          errorText:
                              isErrorPassword ? _errorTextPassword : null,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: confirmpasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Confirm Password',
                          errorText: isErrorConfirmPassword
                              ? _errorTextConfirmPassword
                              : null,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _signUp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //implement authenticate logic here
  void _signUp() async {
    //username validation
    if (nameController.text.trim().isEmpty) {
      setState(() {
        isLoading = true;
        _errorTextUsername = 'Username is empty.';
        _isErrorUsername = true;
      });
    } else {
      setState(() {
        isLoading = true;
        _errorTextUsername = '';
        _isErrorUsername = false;
      });
    }
    //email validation
    if (emailController.text.trim().isEmpty) {
      setState(() {
        isLoading = true;
        _errorTextEmail = 'Email field is empty.';
        isErrorEmail = true;
      });
    } else {
      RegExp reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!reg.hasMatch(emailController.text.trim())) {
        setState(() {
          isLoading = true;
          _errorTextEmail = 'Invalid Email format';
          isErrorEmail = true;
        });
      } else {
        setState(() {
          isLoading = true;
          _errorTextEmail = '';
          isErrorEmail = false;
        });
      }
    }
    //phone number validation
    if (phoneController.text.trim().isEmpty) {
      setState(() {
        isLoading = true;
        _errorTextPhone = 'Phone number is empty';
        isErrorPhone = true;
      });
    } else {
      if (phoneController.text.trim().toString().length != 10) {
        setState(() {
          isLoading = true;
          _errorTextPhone = 'Phone number must be 10';
          isErrorPhone = true;
        });
      } else {
        setState(() {
          isLoading = true;
          _errorTextPhone = '';
          isErrorPhone = false;
        });
      }
    }
    //password validation
    if (passwordController.text.trim().isEmpty) {
      setState(() {
        isLoading = true;
        _errorTextPassword = 'Password field is empty';
        isErrorPassword = true;
      });
    } else {
      if (!compareRegex(passwordController.text,
          r'^(?=.*[A-Z]+)["\w#$%&()*+,\-!./:;<=>?@\[^\]_`{|}~]+$')) {
        setState(() {
          isLoading = true;
          _errorTextPassword =
              'password should include at least a capital letter';
          isErrorPassword = true;
        });
      } else if (!compareRegex(passwordController.text,
          r'^(?=.*["#$%&()*+,\-./:;<=>?@\[^\]_!`{|}~])["\w!#$%&()*+,\-./:;<=>?@\[^\]_`{|}~]+$')) {
        setState(() {
          isLoading = true;
          _errorTextPassword = 'password should contain at least a symbol';
          isErrorPassword = true;
        });
      } else if (!compareRegex(passwordController.text,
          r'^(?=.*\d+)["\w#$%&()*!+,\-./:;<=>?@\[^\]_`{|}~]+$')) {
        setState(() {
          isLoading = true;
          _errorTextPassword = 'password should contain at least a digits';
          isErrorPassword = true;
        });
      } else if (passwordController.text.trim().length < 8) {
        _errorTextPassword =
            'Password entered be must be at least 8 characters.';
        isErrorPassword = true;
      } else {
        setState(() {
          isLoading = true;
          _errorTextPassword = '';
          isErrorPassword = false;
        });
      }
    }
    //confirm password validation
    if (confirmpasswordController.text.isEmpty) {
      setState(() {
        isLoading = true;
        _errorTextConfirmPassword = 'Confirm password field is empty';
        isErrorConfirmPassword = true;
      });
    } else {
      if (passwordController.text.trim() !=
          confirmpasswordController.text.trim()) {
        setState(() {
          isLoading = true;
          _errorTextConfirmPassword = 'Confirm password doesnt match';
          isErrorConfirmPassword = true;
        });
      } else {
        setState(() {
          isLoading = true;
          _errorTextConfirmPassword = '';
          isErrorConfirmPassword = false;
        });
      }
    }
// sending user details to the firebase authentication and firestore
    try {
      if (!_isErrorUsername &&
          !isErrorPassword &&
          !isErrorPhone &&
          !isErrorEmail) {
        User? user = await _auth.signUpWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
          "username": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phoneNumber": phoneController.text.trim(),
        });

        emailController.clear();
        nameController.clear();
        phoneController.clear();
        passwordController.clear();
        print(user);
        showSnackBar(context: context, content: "Account successfully created");
        Navigator.pop(context);
      } else {
        showSnackBar(context: context, content: "An error occurred");
      }
    } catch (e) {
      setState(() {
        _isErrorUsername = true;
        isErrorPassword = true;
        isErrorPhone = true;
        isErrorEmail = true;
      });
      showSnackBar(context: context, content: e.toString());
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }
}

compareRegex(String input, String pattern) {
  RegExp reg = RegExp(pattern);
  return reg.hasMatch(input);
}
