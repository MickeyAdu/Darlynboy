import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReferAndEarnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ReferAndEarnCard(
                    title: 'Share Link',
                    icon: FontAwesomeIcons.link,
                    color: Colors.purple,
                    onTap: () {
                      // Handle share link
                    },
                  ),
                  ReferAndEarnCard(
                    title: 'View Referrals',
                    icon: FontAwesomeIcons.users,
                    color: Colors.teal,
                    onTap: () {
                      // Handle view referrals
                    },
                  ),
                  ReferAndEarnCard(
                    title: 'Rewards',
                    icon: FontAwesomeIcons.gift,
                    color: Colors.amber,
                    onTap: () {
                      // Handle rewards
                    },
                  ),
                  ReferAndEarnCard(
                    title: 'Invite Friends',
                    icon: FontAwesomeIcons.userPlus,
                    color: Colors.pink,
                    onTap: () {
                      // Handle invite friends
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

class ReferAndEarnCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ReferAndEarnCard({
    super.key,
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
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
