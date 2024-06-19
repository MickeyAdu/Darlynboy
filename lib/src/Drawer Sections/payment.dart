// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mic_fuel/src/pay_page.dart';

// class PaymentPage extends StatefulWidget {
//   const PaymentPage({super.key});

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   final _formKey = GlobalKey<FormState>();
//   final amountController = TextEditingController();
//   final referenceController = TextEditingController();
//   final emailController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Momo Payment with Paystack",
//           style: TextStyle(
//               fontFamily: 'Poppins', fontSize: 21, fontWeight: FontWeight.w300),
//         ),
//         elevation: 0,
//       ),
//       body: Form(
//           key: _formKey,
//           child: //Murie's styling of the payment UI
//               Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: amountController,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "required field is missing";
//                     }
//                     return null;
//                   },
//                   // validator: (value) =>
//                   //     value!.isEmpty ? 'reqiured field is missing' : null,
//                   decoration: const InputDecoration(
//                     labelText: 'Amount',
//                     hintText: 'Enter an amount',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 TextFormField(
//                   controller: referenceController,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "required field is missing";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Reference',
//                     hintText: 'Enter the reference',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 TextFormField(
//                   controller: emailController,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "required field is missing";
//                     }
//                     return null;
//                   },
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     hintText: 'Enter your email here',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 45.0,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           if (!_formKey.currentState!.validate()) {
//                             return;
//                           }

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PayPage(
//                                   amount: amountController.text,
//                                   reference: referenceController.text,
//                                   email: emailController.text),
//                             ),
//                           );
//                         },
//                         child: const Text("Proceed to make Payment")),
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
