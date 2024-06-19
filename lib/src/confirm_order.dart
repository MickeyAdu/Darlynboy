import 'package:flutter/material.dart';
import 'package:mic_fuel/src/home.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.amber,
          appBar: AppBar(
            title: const Text(
              'Speed Stop',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Image.asset(
                'truck.png',
                fit: BoxFit.fitWidth,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: const Text('Back to Home Page',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  )),
            ],
          )),
    );
  }
}
