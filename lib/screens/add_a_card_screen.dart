import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/colors.dart';

class AddACardScreen extends StatefulWidget {
  const AddACardScreen({super.key});

  @override
  AddACardScreenState createState() => AddACardScreenState();
}

class AddACardScreenState extends State<AddACardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardholderNameController = TextEditingController();

  bool isValidCardNumber(String input) {
    final cardNumberRegExp = RegExp(r'^\d{16}$');
    return cardNumberRegExp.hasMatch(input);
  }

  bool isValidExpiryDate(String input) {
    final expiryDateRegExp = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
    return expiryDateRegExp.hasMatch(input);
  }

  bool isValidCVV(String input) {
    final cvvRegExp = RegExp(r'^\d{3,4}$');
    return cvvRegExp.hasMatch(input);
  }

  bool isValidCardholderName(String input) {
    return input.isNotEmpty;
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _cardholderNameController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          contentPadding: EdgeInsets.all(24.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Payment Method Successfully Added!',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context, {
                        'provider': 'Card',
                        'cardNumber': _cardNumberController.text,
                        'expiry': _expiryController.text,
                        'cvv': _cvvController.text,
                        'cardholderName': _cardholderNameController.text,
                      }); // Return card details
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 25.sp,
            )),
        title: Text(
          "Payment Card",
          style: textTheme.bodyLarge!.copyWith(
              fontSize: 22, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Link your account",
                    style: textTheme.bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card number',
                      hintText: "eg; 1234567890123456",
                      labelStyle: textTheme.bodySmall,
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      contentPadding: EdgeInsets.all(16.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.w,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.credit_card,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.7),
                        size: 30.sp,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || !isValidCardNumber(value)) {
                        return 'Invalid card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _expiryController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            contentPadding: EdgeInsets.all(16.w),
                            labelText: 'Expiry',
                            hintText: "eg; dd/yy",
                            labelStyle: textTheme.bodySmall,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.w,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.w,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || !isValidExpiryDate(value)) {
                              return 'Invalid expiry date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _cvvController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            labelText: 'CVV',
                            hintText: "eg; 123",
                            labelStyle: textTheme.bodySmall,
                            contentPadding: EdgeInsets.all(16.w),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.w,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.w,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || !isValidCVV(value)) {
                              return 'Invalid CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _cardholderNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      labelText: 'Cardholder name',
                      hintText: "eg; Mickey Mick",
                      labelStyle: textTheme.bodySmall,
                      contentPadding: EdgeInsets.all(16.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.w,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || !isValidCardholderName(value)) {
                        return 'Invalid cardholder name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(mediaQuery.width, 45.h),
                backgroundColor: const Color(0xFF1980e6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text('Add',
                  style: textTheme.bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
