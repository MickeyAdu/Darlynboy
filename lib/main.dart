import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mic_fuel/src/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Fuel Me';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(_title),
          centerTitle: true,
        ),
        body: const LogIn(),
      ),
    );
  }
}
