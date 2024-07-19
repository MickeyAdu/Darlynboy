import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mic_fuel/src/final_page.dart';
import 'package:mic_fuel/src/live_tracking_methods.dart';
import 'package:mic_fuel/src/transaction/api_key/api_key.dart';
import 'package:mic_fuel/src/transaction/paystack/paystack_auth_respose.dart';
import 'package:http/http.dart' as http;
import 'package:mic_fuel/themes/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mic_fuel/src/transaction/transaction.dart' as my_transaction;

class PayPage extends StatefulWidget {
  const PayPage({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final String amount;

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  late WebViewController _controller;
  String? reference;

  Future<PaystackAuthRespose> createTransaction(
      my_transaction.Transaction transaction, String email) async {
    const String url = 'https://api.paystack.co/transaction/initialize';
    final data = transaction.toJson();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${ApiKey.secretKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        reference = responseData['data']['reference'];
        return PaystackAuthRespose.fromJson(responseData['data']);
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Payment unsuccessful: ${errorData['message']}';
      }
    } on Exception catch (e) {
      throw 'Payment unsuccessful: $e';
    }
  }

  Future<bool> verifyTransaction(String? reference) async {
    final url = 'https://api.paystack.co/transaction/verify/$reference';
    final headers = {
      'Authorization': 'Bearer ${ApiKey.secretKey}',
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['data']['status'] == 'success';
      } else {
        final errorData = jsonDecode(response.body);
        throw 'Verification unsuccessful: ${errorData['message']}';
      }
    } on Exception catch (e) {
      throw 'Verification unsuccessful: $e';
    }
  }

  void _onPageFinished(String url) async {
    print(url);
    if (url.contains("https://michealadu.com")) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProgressScreen(),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              // User not signed in, show sign-in screen
              return Center(
                child: Text(
                  'Please sign in to proceed.',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              final email = snapshot.data!.email;
              if (email == null) {
                // Handle case where email field is missing
                return Center(
                  child: Text(
                    'Error: Email field is missing in user data.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return FutureBuilder<PaystackAuthRespose>(
                future: createTransaction(
                  my_transaction.Transaction(
                    amount: (double.parse(widget.amount) * 100).toInt(),
                    currency: 'GHS',
                    email: email,
                  ),
                  email,
                ),
                builder: (context, transactionSnapshot) {
                  if (transactionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (transactionSnapshot.hasError ||
                      !transactionSnapshot.hasData) {
                    return Center(
                      child: Text(
                        'Error initializing transaction: ${transactionSnapshot.error ?? "Unknown error"}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    final url = transactionSnapshot.data!.authorization_url;
                    return WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setBackgroundColor(const Color(0x00000000))
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onProgress: (int progress) {
                              _onPageFinished(url);
                            },
                            onPageStarted: (String url) {
                              _onPageFinished(url);
                            },
                            onPageFinished: (String url) {
                              _onPageFinished(url);
                            },
                            onWebResourceError: (WebResourceError error) {},
                            onNavigationRequest: (NavigationRequest request) {
                              if (request.url
                                  .startsWith('https://www.youtube.com/')) {
                                return NavigationDecision.prevent;
                              }
                              return NavigationDecision.navigate;
                            },
                          ),
                        )
                        ..loadRequest(Uri.parse(url)),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
