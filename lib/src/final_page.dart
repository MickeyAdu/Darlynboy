import 'package:flutter/material.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double daysProgress = 6.0;
  double experienceProgress = 1735.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Bars'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: daysProgress / 7,
                  strokeWidth: 10,
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                ),
                Text(
                  '${daysProgress.toInt()} days',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 40),
            LinearProgressIndicator(
              value: experienceProgress / 2000,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            ),
            SizedBox(height: 10),
            Text(
              '${experienceProgress.toInt()} Experience',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
