import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mic_fuel/screens/sign_in_screen.dart';
import 'package:mic_fuel/src/login.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isAgreed = false;
  bool _loading = false;

  String? _errorTextEmail;
  String? _errorTextPassword;
  String? _errorTextConfirmPassword;
  String? _errorTextPhone;
  bool isErrorEmail = false;
  bool isErrorPassword = false;
  bool isErrorConfirmPassword = false;
  bool isErrorPhone = false;

  // void _registerUser() {
  //   setState(() {
  //     _loading = true;
  //   });
  //   // Registration logic here
  //   setState(() {
  //     _loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 220,
                width: mediaQuery.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [KColors.primaryOrange, KColors.primaryWhite])),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Text(
                        "Fuel Me",
                        style: textTheme.bodyLarge!
                            .copyWith(color: Colors.white, fontSize: 50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 45),
                      child: Text(
                        "Create an Account",
                        style:
                            textTheme.bodyMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                            labelText: 'First Name',
                                            contentPadding: EdgeInsets.all(10.0
                                                .w), // Or EdgeInsets.all(10.w) if using a responsive library
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5
                                                    .w, // Adjust to 1.5.w if using a responsive library
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Ensure the radius is the same as enabledBorder
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5
                                                    .w, // Adjust to 1.5.w if using a responsive library
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your first name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _lastNameController,
                                          decoration: InputDecoration(
                                            labelText: 'Last Name',
                                            contentPadding: EdgeInsets.all(10.0
                                                .w), // Or EdgeInsets.all(10.w) if using a responsive library
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5
                                                    .w, // Adjust to 1.5.w if using a responsive library
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10.0), // Ensure the radius is the same as enabledBorder
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5
                                                    .w, // Adjust to 1.5.w if using a responsive library
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your last name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            contentPadding: EdgeInsets.all(10.0
                                                .w), // or EdgeInsets.all(10.w) if using a responsive library
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            errorText: isErrorEmail
                                                ? _errorTextEmail
                                                : null,
                                            errorStyle: const TextStyle(
                                                color: Colors.red),
                                          ),
                                          validator: (value) => value!.isEmpty
                                              ? 'Please enter an email'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 10.0
                                          .h), // or height: 10.h if using a responsive library

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: !_passwordVisible,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(10.0
                                                .w), // or EdgeInsets.all(10.w) if using a responsive library
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5.w,
                                              ),
                                            ),
                                            labelText: 'Password',
                                            errorText: isErrorPassword
                                                ? _errorTextPassword
                                                : null,
                                            errorStyle: const TextStyle(
                                                color: Colors.red),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (value) => value!.isEmpty
                                              ? 'Please enter a password'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 10.0
                                          .h), // or height: 10.h if using a responsive library

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          obscureText: !_confirmPasswordVisible,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(
                                                10.0), // or EdgeInsets.all(10.w) if using a responsive library
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                            ),
                                            labelText: 'Confirm Password',
                                            errorText: isErrorConfirmPassword
                                                ? _errorTextConfirmPassword
                                                : null,
                                            errorStyle: const TextStyle(
                                                color: Colors.red),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _confirmPasswordVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _confirmPasswordVisible =
                                                      !_confirmPasswordVisible;
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (value) => value !=
                                                  _passwordController.text
                                              ? 'Passwords do not match'
                                              : value!.isEmpty
                                                  ? 'Please enter confirm Password'
                                                  : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 10.0
                                          .h), // or height: 10.h if using a responsive library

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: _phoneController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(
                                                10.0), // or EdgeInsets.all(10.w) if using a responsive library
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: KColors.primaryBlack,
                                                width: 1.5,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                              ),
                                            ),
                                            labelText: 'Phone Number',
                                            errorText: isErrorPhone
                                                ? _errorTextPhone
                                                : null,
                                            errorStyle: const TextStyle(
                                                color: Colors.red),
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your phone number';
                                            } else if (value.length != 10) {
                                              return 'Phone number must be 10 digits';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  CheckboxListTile(
                                    title: const Text(
                                      "I agree with the privacy policy",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    value: _isAgreed,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _isAgreed = newValue!;
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() &&
                                            _isAgreed) {
                                          _registerUser();
                                        }
                                      },
                                      child: Text('Sign Up'),
                                      style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              Colors.red, // Button color
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          textStyle: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        Text('Already have an account?'),
                                        TextButton(
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LogIn(
                                                    // label: 'password',
                                                    )),
                                          ),
                                          child: const Text(
                                            'Sign In',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 17,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _loading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : SizedBox(),
                                ],
                              ),
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

    setState(() => _loading = true);

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
        'role': 'user',
      });
      //set the prices too

      _showRegistrationSuccessful();
    } catch (e) {
      _showError('Failed to register: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
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
                      builder: (context) => LogIn(
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
