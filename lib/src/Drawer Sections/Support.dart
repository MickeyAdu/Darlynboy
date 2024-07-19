import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  SupportCard(
                    title: 'FAQ',
                    icon: FontAwesomeIcons.questionCircle,
                    color: Colors.blueAccent,
                    onTap: () {
                      // Handle FAQ
                    },
                  ),
                  SupportCard(
                    title: 'Contact Us',
                    icon: FontAwesomeIcons.phone,
                    color: Colors.green,
                    onTap: () {
                      // Handle contact us
                    },
                  ),
                  SupportCard(
                    title: 'Live Chat',
                    icon: FontAwesomeIcons.comments,
                    color: Colors.orange,
                    onTap: () {
                      // Handle live chat
                    },
                  ),
                  SupportCard(
                    title: 'Feedback',
                    icon: FontAwesomeIcons.solidSmile,
                    color: Colors.purple,
                    onTap: () {
                      // Handle feedback
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  SupportCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: color,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FaIcon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
