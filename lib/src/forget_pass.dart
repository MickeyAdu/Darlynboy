import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mic_fuel/src/authenticate/Auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();

      // Check for email existence (optional, depending on use case)
      // You can use Firestore or a custom user collection to check for existence
      // ...

      try {
        await AuthService().sendPasswordResetEmail(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password reset link sent to your email.'),
          ),
        );
        Navigator.pop(context); // Navigate back (if applicable)
      } on FirebaseAuthException catch (e) {
        _handleFirebaseAuthError(e);
      } catch (e) {
        // Handle other errors
      }
    }
  }

  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String message = 'An error occurred. Please try again.';
    switch (e.code) {
      case 'user-not-found':
        message =
            'The email address you entered is not associated with an account.';
        break;
      case 'invalid-email':
        message = 'Please enter a valid email address.';
        break;
      // Add other error handling cases if needed
      default:
        break;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    (value!.isEmpty) ? 'Email is required' : null,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _sendResetEmail,
                child: Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
