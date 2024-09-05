import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';
import 'add_a_card_screen.dart';
import 'add_momo_screen.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<PaymentMethodItem> addedPaymentMethods = [];
  bool isQuickSwitchEnabled = false; // Track the state of the Quick Switch

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var greenColor =
        const Color.fromARGB(255, 19, 138, 23); // Define the green color
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Payment Methods',
          style: textTheme.bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 25.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PaymentMethodTile(
              icon: Icons.credit_card,
              title: 'Add a card',
              subtitle: 'Visa, Mastercard, American Express',
              onTap: () async {
                final cardDetails = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddACardScreen(),
                  ),
                );

                if (cardDetails != null) {
                  setState(() {
                    addedPaymentMethods.add(PaymentMethodItem(
                      provider: 'Card',
                      phone: cardDetails['cardNumber'],
                      name: cardDetails['cardholderName'],
                    ));
                  });
                }
              },
            ),
            PaymentMethodTile(
              icon: Icons.mobile_friendly_outlined,
              title: 'Add MOMO Account',
              subtitle: 'MTN, Telecel, AirtelTigo',
              onTap: () async {
                final newPaymentMethod = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMoMoScreen(),
                  ),
                );

                if (newPaymentMethod != null) {
                  setState(() {
                    addedPaymentMethods.add(PaymentMethodItem(
                      provider: newPaymentMethod['provider'],
                      phone: newPaymentMethod['phone'],
                      name: newPaymentMethod['name'],
                    ));
                  });
                }
              },
            ),
            SizedBox(height: 16.h),
            if (addedPaymentMethods.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Text(
                  'Added Payment Methods:',
                  style: textTheme.bodyLarge!.copyWith(
                      color: isQuickSwitchEnabled
                          ? greenColor
                          : KColors.primaryBlack),
                ),
              ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: addedPaymentMethods.length,
                itemBuilder: (context, index) {
                  final paymentMethod = addedPaymentMethods[index];
                  return ListTile(
                    title: Text(
                      '${paymentMethod.name} (${paymentMethod.provider})',
                      style: textTheme.bodyLarge!.copyWith(
                          color: isQuickSwitchEnabled
                              ? greenColor
                              : KColors.primaryBlack),
                    ),
                    subtitle: Text(
                      paymentMethod.phone,
                      style: TextStyle(
                          color: isQuickSwitchEnabled
                              ? greenColor
                              : KColors.primaryBlack),
                    ),
                    leading: Icon(
                      Icons.mobile_screen_share_outlined,
                      size: 30.sp,
                      color: isQuickSwitchEnabled
                          ? greenColor
                          : KColors.primaryBlack,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0.h),
              child: Text('Quick Switch', style: textTheme.bodyLarge),
            ),
            QuickSwitch(
              isSwitched: isQuickSwitchEnabled,
              onSwitchChanged: (value) {
                setState(() {
                  isQuickSwitchEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodItem {
  final String provider;
  final String phone;
  final String name;

  PaymentMethodItem({
    required this.provider,
    required this.phone,
    required this.name,
  });
}

class PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const PaymentMethodTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 16.w),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickSwitch extends StatelessWidget {
  final bool isSwitched;
  final ValueChanged<bool> onSwitchChanged;

  const QuickSwitch({
    super.key,
    required this.isSwitched,
    required this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SwitchListTile(
      title: Text(
        'Enable all payment methods',
        style: textTheme.bodyMedium,
      ),
      value: isSwitched,
      onChanged: onSwitchChanged,
      activeColor: const Color.fromARGB(255, 19, 138, 23),
      inactiveTrackColor: Colors.grey[300],
    );
  }
}
