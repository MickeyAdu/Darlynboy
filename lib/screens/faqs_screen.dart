import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_animated_container.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Frequently Asked Questions",
              style: textTheme.bodyLarge!.copyWith(
                  fontSize: 22, color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedContainer(
              question: "What is FuelMe",
              answer:
                  "FuelMe is a mobile application that delivers fuel directly to you. Our services are available to you 24/7. It's a convenient and easy-to-use mobile application designed to save you time and provide fuel wherever you are.",
            ),
            SizedBox(
              height: 10.h,
            ),
            const CustomAnimatedContainer(
              question: "How do I schedule a delivery",
              answer:
                  "To schedule a delivery, simply open the FuelMe app, select your location, choose the type of fuel you need, and pick a delivery time that suits you. You will receive a confirmation once the order is placed.",
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedContainer(
              question: "How do I pay for fuel",
              answer:
                  "Payments can be made securely through the app using your preferred payment method, including credit/debit cards or mobile wallets. You will receive a receipt after payment is completed.",
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedContainer(
              question: "Can I buy fuel of my choice",
              answer:
                  "Yes, you can choose the type and grade of fuel that best suits your vehicle from the options available in the app. FuelMe offers a variety of fuel types to meet your needs.",
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedContainer(
              question: "Can I buy fuel from Goil",
              answer:
                  "Currently, FuelMe partners with a wide range of trusted fuel suppliers, including Goil. You can select Goil as your preferred supplier when placing an order through the app.",
            ),
          ],
        ),
      ),
    );
  }
}
