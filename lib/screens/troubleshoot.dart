import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/colors.dart';
import '../widgets/custom_animated_container.dart';

class TroubleshootScreen extends StatefulWidget {
  const TroubleshootScreen({super.key});

  @override
  State<TroubleshootScreen> createState() => _TroubleshootScreenState();
}

class _TroubleshootScreenState extends State<TroubleshootScreen> {
  bool isTapped = false;
  final TextEditingController _issueController = TextEditingController();
  final ValueNotifier<String> _issueNotifier = ValueNotifier<String>('');

  void _submitIssue() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your issue has been submitted'),
        duration: Duration(seconds: 2),
      ),
    );
    _issueController.clear();
    _issueNotifier.value = '';
    setState(() {
      isTapped = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _issueController.addListener(() {
      _issueNotifier.value = _issueController.text;
    });
  }

  @override
  void dispose() {
    _issueController.dispose();
    _issueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Troubleshooting",
              style: textTheme.bodyLarge!.copyWith(
                  fontSize: 22, color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedContainer(
              question: "My order didn't arrive",
              answer:
                  "If your order didn't arrive, please check the app for updates on your order status. You can also contact our customer support through the app for further assistance. We are committed to resolving any issues as quickly as possible.",
            ),
            SizedBox(
              height: 10.h,
            ),
            const CustomAnimatedContainer(
              question: "I need to cancel my order",
              answer:
                  "To cancel your order, go to the 'My Orders' section in the app, select the order you wish to cancel, and choose the 'Cancel Order' option. Please note that orders can only be canceled before they are dispatched.",
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedContainer(
              question: "Change location of delivery",
              answer:
                  "If you need to change the delivery location, please do so as soon as possible before the order is dispatched. Go to 'My Orders,' select the order, and update the delivery location. If the order has already been dispatched, please contact customer support.",
            ),
            SizedBox(height: 20.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300), // animation duration
              padding: EdgeInsets.all(10.w),
              width: mediaQuery.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  width: 1.w,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "I have a different issue",
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isTapped = !isTapped;
                            });
                          },
                          icon: Icon(
                            isTapped
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isTapped)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
                      child: TextField(
                        controller: _issueController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16.w),
                          hintText: "Please type here",
                          hintStyle: textTheme.bodyMedium,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.7),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isTapped)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: ValueListenableBuilder<String>(
                        valueListenable: _issueNotifier,
                        builder: (context, issue, child) {
                          return ElevatedButton(
                            onPressed: issue.isNotEmpty ? _submitIssue : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              fixedSize: Size(120.h, 40.h),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Text(
                              "Submit",
                              style: textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
