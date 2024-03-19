import 'package:flutter/material.dart';
import 'package:mic_fuel/src/forget_pass.dart';
import 'package:mic_fuel/src/home.dart';
import 'package:mic_fuel/src/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../services/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  // final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  String _errorTextUsername = '';
  String _errorTextPassword = '';
  bool _isErrorUsername = false;
  bool _isErrorPassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    // emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  'Sign in',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        labelText: 'User Name',
                        errorText: _isErrorUsername ? _errorTextUsername : null,
                        errorStyle: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      labelText: 'Password',
                      errorText: _isErrorPassword ? _errorTextPassword : null,
                      errorStyle: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => forgetpass()),
                );
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: _validate,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account?",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                )
              ],
            ),
          ],
        ));
  }

  //login here
  void _validate() async {
    if (_passwordController.text.trim().isEmpty) {
      setState(() {
        _errorTextPassword = ' Password field is empty';
        _isErrorPassword = true;
      });
    } else {
      setState(() {
        _errorTextPassword = '';
        _isErrorPassword = false;
      });
    }
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _errorTextUsername = ' Username field is empty';
        _isErrorUsername = true;
      });
    } else {
      setState(() {
        _errorTextUsername = '';
        _isErrorUsername = false;
      });
    }

    if (_formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _nameController.text.trim(),
                password: _passwordController.text.trim());

        if (credential.user != null) {
          //Navigate to the screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //Handle User not found error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Invalid email or password"),
            ),
          );
        } else if (e.code == 'wrong-password') {
          //Handle wrong password error form firebase
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Password, try again!")));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Password, try again!")));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Password, try again!")));
        }
      }
    }
  }
}
