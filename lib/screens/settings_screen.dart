import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package
import 'package:mic_fuel/screens/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the shared_preferences package

import '../themes/colors.dart';
import 'email_settings_screen.dart';
import 'payment_mehods_screen.dart';
import 'privacy_policy.dart';
import 'profile_screen.dart';
import 'push_notifications_screem.dart';
import 'rate_app.dart';
import 'terms_of_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    var titleStyle = textTheme.bodyLarge!
        .copyWith(color: Theme.of(context).colorScheme.primary);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Settings', style: textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Account Management'),
            SettingItem(
              title: 'Profile',
              style: titleStyle,
              subtitle: 'Edit profile',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            ),
            SettingItem(
              title: 'Payment Methods',
              style: titleStyle,
              subtitle: 'Add or remove payment methods',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentMethodsScreen()));
              },
            ),
            const SectionTitle(title: 'Notification Preferences'),
            SettingItem(
              title: 'Push Notifications',
              style: titleStyle,
              subtitle: 'Set up push notifications',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PushNotifications()));
              },
            ),
            SettingItem(
              title: 'Emails',
              style: titleStyle,
              subtitle: 'Manage your email preferences',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmailSettingsScreen()));
              },
            ),
            SettingItem(
              title: 'Toggle Modes',
              style: titleStyle,
              subtitle: 'Choose either Light or dark mode',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DarkMode()));
              },
            ),
            SectionTitle(title: 'App Settings', style: titleStyle),
            SettingItem(
              title: 'Language',
              style: titleStyle,
              trailing: Text(
                'English',
                style: textTheme.bodyMedium?.copyWith(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.5)),
              ),
              onTap: () {},
            ),
            SettingItem(
              title: 'Rate the app',
              style: titleStyle,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RateAppScreen()));
              },
            ),
            SettingItem(
              title: 'Privacy Policy',
              style: titleStyle,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen()));
              },
            ),
            SettingItem(
              title: 'Terms of Service',
              style: titleStyle,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsOfServiceScreen()));
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: Size(mediaQuery.width, 45.h),
            //       backgroundColor: Colors.orange,
            //       padding: EdgeInsets.all(6.0.w),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     onPressed: () =>
            //         _saveChanges(context), // Call the save function here
            //     child: Text('Save Changes',
            //         style: textTheme.bodyLarge?.copyWith(
            //             color: Theme.of(context).colorScheme.primary)),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// SectionTitle widget remains unchanged
class SectionTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;

  const SectionTitle({super.key, required this.title, this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// SettingItem widget remains unchanged
class SettingItem extends StatelessWidget {
  final String title;

  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;
  final TextStyle? style;

  const SettingItem({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text(
        title,
        style: style ??
            TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                color: Color(0xFF886C63),
                fontSize: 14,
              ),
            )
          : null,
      trailing: trailing ??
          Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).colorScheme.primary, size: 20),
      onTap: onTap,
    );
  }
}
