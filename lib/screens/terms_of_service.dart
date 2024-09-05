import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  TermsOfServiceScreenState createState() => TermsOfServiceScreenState();
}

class TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  bool _isChecked = false;

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  void _handleAgree() async {
    // to disable the button to prevent multiple presses
    setState(() {
      _isChecked = false;
    });

    // snackbar or loading indicator if desired
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Processing...'),
      ),
    );
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service', style: textTheme.bodyLarge),
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
              'Terms of Service',
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
                      title: '1. Acceptance of Terms',
                      content:
                          'By using our app, you agree to be bound by these Terms of Service and our Privacy Policy. If you do not agree with these terms, please do not use our app.',
                    ),
                    _buildSection(
                      title: '2. Changes to Terms',
                      content:
                          'We reserve the right to modify these Terms of Service at any time. Your continued use of the app following any changes signifies your acceptance of the updated terms.',
                    ),
                    _buildSection(
                      title: '3. User Responsibilities',
                      content:
                          'You are responsible for your use of the app and must ensure that your activities comply with all applicable laws and regulations.',
                    ),
                    _buildSection(
                      title: '4. Limitation of Liability',
                      content:
                          'We are not liable for any damages arising from your use or inability to use the app. Our liability is limited to the maximum extent permitted by law.',
                    ),
                    _buildSection(
                      title: '5. Termination',
                      content:
                          'We reserve the right to terminate or suspend your access to the app if you violate these Terms of Service.',
                    ),
                    _buildSection(
                      title: '6. Governing Law',
                      content:
                          'These Terms of Service are governed by and construed in accordance with the laws of the jurisdiction in which we operate.',
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
                    'I have read and agree to the Terms of Service',
                    style: textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
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
            style: TextStyle(
                fontSize: 14.sp, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
