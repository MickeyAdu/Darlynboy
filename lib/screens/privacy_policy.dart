import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  PrivacyPolicyScreenState createState() => PrivacyPolicyScreenState();
}

class PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool _isChecked = false;

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _handleAgree() async {
    // this disables the button to prevent multiple presses
    setState(() {
      _isChecked = false;
    });

    //  a snackbar or loading indicator if desired
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Processing...'),
      ),
    );

    // to delay before navigating back for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy', style: textTheme.bodyLarge),
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).colorScheme.primary, size: 25.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline,
                color: Theme.of(context).colorScheme.primary, size: 25.sp),
            onPressed: () {
              // Add info dialog or functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: textTheme.headlineMedium!.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: '1. Information We Collect',
                      content:
                          'We collect information you provide directly to us, such as when you create an account, fill out a form, or contact us for support. We also collect information automatically through your use of the app.',
                    ),
                    _buildSection(
                      title: '2. How We Use Your Information',
                      content:
                          'We use the information we collect to provide, maintain, and improve our services. We may also use your information to communicate with you and to show you relevant content.',
                    ),
                    _buildSection(
                      title: '3. Sharing Your Information',
                      content:
                          'We do not share your personal information with third parties without your consent, except as necessary to comply with legal requirements.',
                    ),
                    _buildSection(
                      title: '4. Security',
                      content:
                          'We take reasonable measures to help protect your information from unauthorized access, use, or disclosure.',
                    ),
                    _buildSection(
                      title: '5. Your Rights',
                      content:
                          'You have the right to access, correct, or delete your personal information. You may also object to or restrict certain types of processing.',
                    ),
                    _buildSection(
                      title: '6. Changes to This Policy',
                      content:
                          'We may update this policy from time to time. We will notify you of any changes by posting the new policy on our app.',
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey[400]),
            SizedBox(height: 16.h),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: _handleCheckboxChange,
                ),
                Expanded(
                  child: Text(
                    'I have read and understood the privacy policy',
                    style: textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(mediaQuery.width, 45.h),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: .5.w),
              ),
              onPressed: _isChecked ? _handleAgree : null,
              child: Text(
                "I Agree",
                style: textTheme.bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
