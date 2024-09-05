import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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

  // Stream to listen for order status updates
  Stream<OrderData> _listenForOrderStatusUpdates(String orderId) {
    return _firestore.collection('Order_Details').doc(orderId).snapshots().map(
          (doc) => OrderData.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Keeps the column size to its minimum height
              children: [
                Text(
                  'Orders',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 21,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 60,
                  height: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          automaticallyImplyLeading: false, // Remove the back button
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<OrderData>>(
            stream: _fetchOrderDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final orders = snapshot.data!;
                return ListView.builder(
                  shrinkWrap:
                      true, // Allows ListView to be scrollable within the SingleChildScrollView
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Container(
                      color: Colors.grey.shade300, // Background color grey
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8), // Space between items
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order ID: ${order.documentId}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary, // Text color black
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Fuel Type: ${order.fuelType}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            Text('Quantity: ${order.quantity} liters',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            Text('Station: ${order.fuelStationName}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            Text('Total Price: \GH ${order.priceTotal}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ],
                        ),
                        // trailing: StreamBuilder<OrderData>(
                        //   stream:
                        //       _listenForOrderStatusUpdates(order.documentId),
                        //   builder: (context, statusSnapshot) {
                        //     if (statusSnapshot.hasData) {
                        //       final updatedOrder = statusSnapshot.data!;
                        //       return StatusBadge(updatedOrder
                        //           .status); // Display status with dynamic styling
                        //     } else if (statusSnapshot.hasError) {
                        //       print(
                        //           'Error fetching order status update: ${statusSnapshot.error}');
                        //       return const Text('Error fetching status');
                        //     }
                        //     return const CircularProgressIndicator();
                        //   },
                        // ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                print('Error fetching order details: ${snapshot.error}');
                return const Text('Error fetching orders');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

// Widget for displaying status with dynamic color styling
// class StatusBadge extends StatelessWidget {
//   final String status;

//   StatusBadge(this.status);

//   @override
//   Widget build(BuildContext context) {
//     Color backgroundColor;
//     Color textColor;

//     switch (status) {
//       case 'accepted':
//         backgroundColor = Colors.green.withOpacity(0.1);
//         textColor = Colors.green;
//         break;
//       case 'declined':
//         backgroundColor = Colors.red.withOpacity(0.1);
//         textColor = Colors.red;
//         break;
//       default:
//         backgroundColor = Colors.orange.withOpacity(0.1);
//         textColor = Colors.orange;
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(999),
//       ),
//       child: Text(
//         status,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//         ).copyWith(color: textColor),
//       ),
//     );
//   }
// }

class OrderData {
  final String documentId;
  final String fuelType;
  final double quantity;
  final String fuelStationName;
  final double priceTotal;

  OrderData({
    required this.documentId,
    required this.fuelType,
    required this.quantity,
    required this.fuelStationName,
    required this.priceTotal,
  });

  factory OrderData.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return OrderData(
      documentId: documentId,
      fuelType: data['fuelType'] as String,
      quantity: (data['quantity'] as num).toDouble(),
      fuelStationName: data['fuelStationName'] as String,
      priceTotal: (data['priceTotal'] as num).toDouble(),
    );
  }
}
