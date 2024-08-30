import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletPage extends StatelessWidget {
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
                  WalletCard(
                    title: 'Add Money',
                    icon: FontAwesomeIcons.circlePlus,
                    color: Colors.green,
                    onTap: () {
                      // Handle add money
                    },
                  ),
                  WalletCard(
                    title: 'Transactions',
                    icon: FontAwesomeIcons.clockRotateLeft,
                    color: Colors.blue,
                    onTap: () {
                      // Handle transaction history
                    },
                  ),
                  WalletCard(
                    title: 'Transfer Money',
                    icon: FontAwesomeIcons.rightLeft,
                    color: Colors.orange,
                    onTap: () {
                      // Handle transfer money
                    },
                  ),
                  WalletCard(
                    title: 'Settings',
                    icon: FontAwesomeIcons.gears,
                    color: Colors.purple,
                    onTap: () {
                      // Handle settings
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

class WalletCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const WalletCard({
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
