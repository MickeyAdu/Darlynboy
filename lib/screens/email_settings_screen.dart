import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class EmailSettingsScreen extends StatefulWidget {
  const EmailSettingsScreen({super.key});

  @override
  EmailSettingsScreenState createState() => EmailSettingsScreenState();
}

class EmailSettingsScreenState extends State<EmailSettingsScreen> {
  bool promotionalEmails = true;
  bool newsletters = false;
  bool accountNotifications = true;
  String emailFrequency = 'Weekly';

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Settings', style: textTheme.bodyLarge),
        backgroundColor: Colors.grey[50],
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black, size: 25.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your email preference',
              style: textTheme.bodyLarge!
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose what kind of emails you want to receive from us.',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 16.h),
            SwitchListTile(
              title: Text('Promotional Emails', style: textTheme.bodyLarge),
              subtitle: Text('Receive special offers and promotions.',
                  style: textTheme.bodySmall),
              value: promotionalEmails,
              onChanged: (bool value) {
                setState(() {
                  promotionalEmails = value;
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: KColors.primaryBlack,
            ),
            SwitchListTile(
              title: Text('Newsletters', style: textTheme.bodyLarge),
              subtitle: Text('Stay updated with our latest news.',
                  style: textTheme.bodySmall),
              value: newsletters,
              onChanged: (bool value) {
                setState(() {
                  newsletters = value;
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: KColors.primaryBlack,
            ),
            SwitchListTile(
              title: Text('Account Notifications', style: textTheme.bodyLarge),
              subtitle: Text('Get notified about important account updates.',
                  style: textTheme.bodySmall),
              value: accountNotifications,
              onChanged: (bool value) {
                setState(() {
                  accountNotifications = value;
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: KColors.primaryBlack,
            ),
            SizedBox(height: 16.h),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Email Frequency',
                labelStyle: textTheme.bodyMedium,
                border: const OutlineInputBorder(),
              ),
              value: emailFrequency,
              items: ['Daily', 'Weekly', 'Monthly'].map((String frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency, style: textTheme.bodyMedium),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  emailFrequency = newValue!;
                });
              },
            ),
            SizedBox(height: 160.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(mediaQuery.width, 45.h),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                side: BorderSide(color: KColors.primaryBlack, width: .5.w),
              ),
              onPressed: () {},
              child: Text(
                "Save changes",
                style:
                    textTheme.bodyLarge!.copyWith(color: KColors.primaryWhite),
              ),
            )
          ],
        ),
      ),
    );
  }
}
