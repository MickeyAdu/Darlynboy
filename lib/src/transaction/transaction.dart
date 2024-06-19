import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transaction {
  final int amount;
  final String currency;
  final String email;

  Transaction({
    required this.amount,
    required this.currency,
    required this.email,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['totalPrice'] as int,
      currency: json['currency'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount.toString(),
      'currency': currency,
      'email': email,
    };
  }

  static Future<String?> fetchEmailFromFirestore(String userId) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userData.exists) {
        return userData["email"] as String?;
      } else {
        return '@gmail.com';
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}
