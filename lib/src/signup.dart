// ignore_for_file: avoid_print, use_build_context_synchronously, unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mic_fuel/common/snackbar.dart';
import 'package:mic_fuel/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final Authservice _auth = Authservice();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
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
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: const Text(
            'Fuel Me',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          if (isLoading)
            Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                  child: CircularProgressIndicator(
                color: Colors.grey,
              )),
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
                            fontSize: 30),
                      )),
                  const Padding(padding: EdgeInsets.only(top: 40)),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: const Text('Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () => _signUp()

                        // // ignore: avoid_print
                        // print(nameController.text);
                        // print(passwordController.text);
                        // print(emailController.text);
                        // print(phoneController.text);
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(const SnackBar(
                        //   content: Text("Account has been created"),
                        // ));
                        // Navigator.of(context).pop();
                        ,
                      )),
                ],
              )),
        ]));
  }

  //implement authenticate on this page
  void _signUp() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (nameController.text.trim().isNotEmpty &&
          emailController.text.trim().isNotEmpty &&
          phoneController.text.trim().isNotEmpty &&
          passwordController.text.trim().isNotEmpty) {
        User? user = await _auth.signUpWithEmailAndPassword(
            emailController.text.trim(), passwordController.text.trim());
        firestore.collection('users').doc(firebaseAuth.currentUser!.uid).set({
          "username": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phoneNumber": phoneController.text.trim(),
        });
        emailController.text = "";
        nameController.text = "";
        phoneController.text = "";
        passwordController.text = "";
        print(user);
      } else {
        showSnackBar(context: context, content: "An error occured");
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context: context, content: e.toString());
      print(e.toString());
    }
  }
}
