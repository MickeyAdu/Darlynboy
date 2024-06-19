import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/themes/colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream to fetch order details based on document ID
  Stream<List<OrderData>> _fetchOrderDetails() {
    User? user = FirebaseAuth.instance.currentUser;
    return _firestore.collection('Order_Details').snapshots().map(
          (snapshot) => snapshot.docs
              .where((doc) => doc['user_ID'] == user?.uid) // Filter by user ID
              .map((doc) => OrderData.fromFirestore(
                  doc.data() as Map<String, dynamic>,
                  doc.id)) // Use document ID
              .toList(),
        );
  }

  // Stream to listen for order status updates (unchanged)
  Stream<OrderData> _listenForOrderStatusUpdates(String orderId) {
    return _firestore.collection('Order_Details').doc(orderId).snapshots().map(
          (doc) => OrderData.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Order History',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.normal,
              color: KColors.primaryGreen,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: StreamBuilder<List<OrderData>>(
        stream: _fetchOrderDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title:
                      Text('Order ID: ${order.documentId}'), // Use document ID
                  subtitle: Text('Status: ${order.status}'),
                  trailing: StreamBuilder<OrderData>(
                    stream: _listenForOrderStatusUpdates(
                        order.documentId), // Use document ID
                    builder: (context, statusSnapshot) {
                      if (statusSnapshot.hasData) {
                        final updatedOrder = statusSnapshot.data!;
                        return Text('Status: ${updatedOrder.status}');
                      } else if (statusSnapshot.hasError) {
                        print(
                            'Error fetching order status update: ${statusSnapshot.error}');
                        return const Text('Error fetching status');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print('Error fetching order details: ${snapshot.error}');
            return const Text('Error fetching orders');
          }
          return const Center(
              child:
                  CircularProgressIndicator()); // Show loading indicator initially
        },
      ),
    );
  }
}

class OrderData {
  final String documentId; // Use document ID instead of user_ID
  final String status;

  OrderData({required this.documentId, required this.status});

  factory OrderData.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return OrderData(
      documentId: documentId, // Use document ID from parameter
      status: data['trans_process_state'] as String,
    );
  }
}
