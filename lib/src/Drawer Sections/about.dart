import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
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
                  AboutCard(
                    title: 'Our Story',
                    icon: FontAwesomeIcons.book,
                    color: Colors.indigo,
                    onTap: () {
                      // Handle our story
                    },
                  ),
                  AboutCard(
                    title: 'Our Mission',
                    icon: FontAwesomeIcons.bullseye,
                    color: Colors.deepPurple,
                    onTap: () {
                      // Handle our mission
                    },
                  ),
                  AboutCard(
                    title: 'Team',
                    icon: FontAwesomeIcons.users,
                    color: Colors.blue,
                    onTap: () {
                      // Handle team
                    },
                  ),
                  AboutCard(
                    title: 'Careers',
                    icon: FontAwesomeIcons.briefcase,
                    color: Colors.deepOrange,
                    onTap: () {
                      // Handle careers
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

class AboutCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  AboutCard({
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
