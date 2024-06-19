import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/themes/colors.dart';

class HomeScreenw extends StatefulWidget {
  const HomeScreenw({super.key});

  @override
  _HomeScreenwState createState() => _HomeScreenwState();
}

class _HomeScreenwState extends State<HomeScreenw>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedStatus = 'pending'; // Track the currently selected status
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Delivered'),
          ],
          onTap: (index) {
            setState(() {
              selectedStatus = ['pending', 'accepted', 'delivered'][index];
            });
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Order_Details')
            .where('trans_process_state', isEqualTo: selectedStatus)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No $selectedStatus orders found.'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: KColors.primaryGrey,
              ),
              child: ListView(
                children: snapshot.data!.docs.map((document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () =>
                        navigateToDetails(document.id), // Pass document ID
                    child: ListTile(
                      title: Text(data['fuelType'] ?? 'No fuel type found'),
                      subtitle: Text('Quantity: ${data['quantity'] ?? "0"}'
                          '\n'
                          'Location: ${data['location'] ?? 'Ghana'}'),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToDetails(String orderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(orderId: orderId),
      ),
    );
  }
}

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailsScreen({required this.orderId, super.key});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _isLoading = false;

  Future<void> _updateOrderStatusAndMoveToAccepted() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('Order_Details')
          .doc(widget.orderId)
          .get();

      if (orderSnapshot.exists) {
        Map<String, dynamic> orderData =
            orderSnapshot.data() as Map<String, dynamic>;
        orderData['trans_process_state'] = 'accepted';

        // Move the order to the Updated_orders collection
        await FirebaseFirestore.instance
            .collection('Updated_orders')
            .doc(widget.orderId)
            .set(orderData);

        // Update the trans_process_state in the original collection
        await FirebaseFirestore.instance
            .collection('Order_Details')
            .doc(widget.orderId)
            .update({'trans_process_state': 'accepted'});
      }
    } catch (e) {
      print('Error updating order status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  Future<void> _updateOrderStatus(String status) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Update the trans_process_state in the Order_Details collection
      await FirebaseFirestore.instance
          .collection('Order_Details')
          .doc(widget.orderId)
          .update({'trans_process_state': status});

      // Update the trans_process_state in the Updated_orders collection
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('Order_Details')
          .doc(widget.orderId)
          .get();

      if (orderSnapshot.exists) {
        Map<String, dynamic> orderData =
            orderSnapshot.data() as Map<String, dynamic>;
        orderData['trans_process_state'] = status;

        await FirebaseFirestore.instance
            .collection('Updated_orders')
            .doc(widget.orderId)
            .set(orderData);
      }
    } catch (e) {
      print('Error updating order status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Stack(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Order_Details')
                .doc(widget.orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('Order details not found.'));
              }

              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fuel Type: ${data['fuelType'] ?? 'N/A'}',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Quantity: ${data['quantity'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Location: ${data['location'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Status: ${data['trans_process_state'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _updateOrderStatusAndMoveToAccepted();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 12.h),
                            textStyle: TextStyle(fontSize: 16.sp),
                          ),
                          child: const Text('Accept'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _updateOrderStatus('declined');
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 12.h),
                            textStyle: TextStyle(fontSize: 16.sp),
                          ),
                          child: const Text('Decline'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
