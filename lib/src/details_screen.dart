import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:mic_fuel/src/pay_page.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/themes/theme_notifier.dart';
import 'package:mic_fuel/widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Future<Map<String, dynamic>> _detailsFuture;
  int? _selectedStationIndex;
  String _selectedFuelType = "";

  int? isSelectedFuel;
  String? _selectedQuantity;

  Future<Map<String, dynamic>> _fetchDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Order_Details')
        .where('user_ID', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception("No details found for the current user");
    }

    DocumentSnapshot doc = querySnapshot.docs.first;
    return doc.data() as Map<String, dynamic>;
  }

  Future<void> navigateToPayPage(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Order_Details')
        .where('user_ID', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        var data = documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('totalPrice')) {
          double totalPrice = data['totalPrice'];

          // Navigate to PayPage with the retrieved totalPrice
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayPage(
                amount: totalPrice.toString(),
              ),
            ),
          );
        } else {
          print('totalPrice not found in document');
        }
      } else {
        print('Document does not exist');
      }
    } else {
      print('No documents found for the current user');
    }
  }

  // Mapping between fuel station names and image paths
  final Map<String, String> fuelStationImages = {
    'Total Fuel Station': 'assets/total_station.jpg',
    'Shell Fuel Station': 'assets/shell_station.jpg',
    'Goil Fuel Station': 'assets/goil_station.jpg',
    'Petrosol Fuel Station': 'assets/petrolsol_station.jpg',
  };

  @override
  void initState() {
    super.initState();
    _detailsFuture = _fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.sizeOf(context);
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: FutureBuilder<Map<String, dynamic>>(
          future: _detailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data found'));
            }

            var data = snapshot.data!;
            String quantity = data['quantity']?.toString() ?? 'N/A';
            String typeOfFuel = data['fuelType'] ?? 'N/A';
            String totalPrice = data['totalPrice']?.toString() ?? 'N/A';
            String fuelStationName =
                data['fuelStationName']?.toString() ?? 'N/A';
            String location = data['location']?.toString() ?? 'N/A';

            // Get the image path based on the fuel station name
            String imagePath = fuelStationImages[fuelStationName] ??
                'assets/total_station.jpg';

            return Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    width: mediaQuery.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.r),
                        bottomRight: Radius.circular(15.r),
                      ),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        opacity: .95,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.h, left: 16.r, right: 16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0.h),
                          child: Row(
                            children: [
                              IconButton(
                                style: IconButton.styleFrom(
                                  backgroundColor: KColors.secondaryOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9.r),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Maki.fuel,
                                  size: 30.sp,
                                  color: KColors.primaryWhite,
                                ),
                              ),
                              Text(
                                "   ${fuelStationName}",
                                style: textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: KColors.secondaryOrange,
                                size: 25.sp,
                              ),
                              Text(
                                "  $location",
                                style: textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Text(
                            "Quantity:  $quantity",
                            style: textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(
                          "Type of Fuel:  $typeOfFuel",
                          style: textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Text(
                            "Total:  \$$totalPrice",
                            style: textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.h, bottom: 15.h),
                          child:
                              Text("Description", style: textTheme.bodyLarge!),
                        ),
                        Text(
                          "Also known as gasoil, regular fuel is a volatile mixture of liquid hydrocarbons, generally containing small amounts of additives, suitable for use in spark-ignition internal combustion of engines.  It can be used in the construction industry for small scale projects.",
                          style: textTheme.bodySmall,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0.h),
                          child: CustomElevatedButton(
                            label: "Proceed to Payment",
                            onTap: () => navigateToPayPage(context),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
