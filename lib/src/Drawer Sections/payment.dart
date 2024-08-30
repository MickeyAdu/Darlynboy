import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Theme.of(context).colorScheme.primary,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.creditCard,
                      size: 50,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Credit/Debit Card',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '**** **** **** 1234',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: <Widget>[
                  PaymentCard(
                    title: 'Add Card',
                    icon: FontAwesomeIcons.circlePlus,
                    color: Colors.green,
                    onTap: () {
                      // Handle add card
                    },
                  ),
                  PaymentCard(
                    title: 'Transactions',
                    icon: FontAwesomeIcons.clockRotateLeft,
                    color: Colors.blue,
                    onTap: () {
                      // Handle transaction history
                    },
                  ),
                  PaymentCard(
                    title: 'Make Payment',
                    icon: FontAwesomeIcons.moneyBillWave,
                    color: Colors.orange,
                    onTap: () {
                      // Handle make payment
                    },
                  ),
                  PaymentCard(
                    title: 'Payment Settings',
                    icon: FontAwesomeIcons.gears,
                    color: Colors.purple,
                    onTap: () {
                      // Handle payment settings
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

class PaymentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const PaymentCard({
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
