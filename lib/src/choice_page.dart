import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:mic_fuel/src/details_screen.dart';
import 'package:mic_fuel/src/live_tracking_methods.dart';

import '../themes/colors.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custome_fuel_container.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key, required this.selectedStationName});
  final String selectedStationName;

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isEditing = false;
  final TextEditingController _textController = TextEditingController();
  // List of fuel stations
  final List<String> fuelStations = [
    "Total Fuel Station",
    "Shell Fuel Station",
    "Goil Fuel Station",
    "Petrosol Fuel Station"
  ];

  int? _selectedStationIndex;
  String _selectedFuelType = "";
  double? _litres;
  double? _price;
  int? isSelectedFuel;
  String? _selectedQuantity;

  final List<String> _choices = ['1 ', '2 ', '3 ', '4 '];

  @override
  void initState() {
    super.initState();
    _selectedStationIndex = fuelStations.indexOf(widget.selectedStationName);
    fetchLitreAndPrice();
    _textController.text = "Name of Location";
  }

  Future<void> fetchLitreAndPrice() async {
    if (_selectedStationIndex == null || _selectedFuelType.isEmpty) return;

    String stationId;
    switch (_selectedStationIndex) {
      case 0:
        stationId = "fuel_station_id_1"; // document_id
        break;
      case 1:
        stationId = "fuel_station_id_2";
        break;
      case 2:
        stationId = "fuel_station_id_3";
        break;
      case 3:
        stationId = "fuel_station_id_4";
        break;
      default:
        stationId = "fuel_station_id_1";
    }

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('fuel_prices')
          .doc(stationId)
          .get();
      var fuelData = doc['fuels'][_selectedFuelType];
      setState(() {
        _litres = (fuelData['litres'] as num).toDouble();
        _price = (fuelData['price'] as num).toDouble();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> _sendOrderToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (_selectedFuelType.isEmpty ||
        _selectedQuantity == null ||
        _price == null ||
        _textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select fuel type, quantity and Location')),
      );
      return;
    }

    try {
      int quantity;
      switch (_selectedQuantity) {
        case '1 ':
          quantity = 1;
          break;
        case '2 ':
          quantity = 2;
          break;
        case '3 ':
          quantity = 3;
          break;
        case '4 ':
          quantity = 4;
          break;
        default:
          quantity = 0;
      }

      double totalPrice = double.parse((quantity * _price!).toStringAsFixed(2));

      Map<String, dynamic> customerDetails = {
        'fuelStationName': widget.selectedStationName,
        'fuelType': _selectedFuelType,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'timestamp': FieldValue.serverTimestamp(),
        'user_ID': user!.uid,
        'location': _textController.text,
        'trans_process_state': 'pending',
      };

      await _firestore
          .collection('Order_Details')
          .doc('Order #${Random().nextInt(10000) + 1000}')
          .set(customerDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const DetailsScreen()),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error placing order: $e')),
      );
    }
  }

  void _toggleEditing() async {
    if (_isEditing) {
      // Save the new location to Firestore
      // await FirebaseFirestore.instance.collection('Order_Details').add({
      //   'Location_Address': _textController.text,
      // });
    } else {
      // Clear the text field when edit is first clicked
      _textController.clear();
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  padding: EdgeInsets.all(10.w),
                  height: 120.h,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: KColors.primaryGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Maki.fuel,
                            size: 35.sp,
                          ),
                          Text(
                            widget.selectedStationName,
                            style: textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 35.sp,
                                ),
                                _isEditing
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            // borderRadius:
                                            //     // BorderRadius.circular(10.0),
                                            ),
                                        width: 230.sp,
                                        child: TextField(
                                          controller: _textController,
                                          style: textTheme.bodyLarge!.copyWith(
                                              fontWeight: FontWeight.normal),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              // borderSide: const BorderSide(color: Colors.greenAccent),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color:
                                                      KColors.secondaryGreen),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        " ${_textController.text} ",
                                        style: textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: _toggleEditing,
                                  icon: Icon(
                                      _isEditing
                                          ? Icons.check
                                          : Icons.edit_outlined,
                                      size: 25.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Container(
                    margin: EdgeInsets.only(top: 6.h, left: 16.w, right: 16.w),
                    padding: EdgeInsets.all(10.w),
                    height: 180.h,
                    width: mediaQuery.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: KColors.primaryGrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select the type of fuel",
                          style: textTheme.bodyMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectedFuel = 0;
                                  _selectedFuelType = "petrol";
                                });
                                fetchLitreAndPrice();
                              },
                              child: CustomFuelContainer(
                                text: "Petrol",
                                color: isSelectedFuel == 0
                                    ? KColors.secondaryGreen
                                    : Colors.grey.shade200,
                                textColor: isSelectedFuel == 0
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                                iconColor: isSelectedFuel == 0
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectedFuel = 1;
                                  _selectedFuelType = "diesel";
                                });
                                fetchLitreAndPrice();
                              },
                              child: CustomFuelContainer(
                                text: "Diesel",
                                color: isSelectedFuel == 1
                                    ? KColors.secondaryGreen
                                    : Colors.grey.shade200,
                                textColor: isSelectedFuel == 1
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                                iconColor: isSelectedFuel == 1
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelectedFuel = 2;
                                  _selectedFuelType = "gas";
                                });
                                fetchLitreAndPrice();
                              },
                              child: CustomFuelContainer(
                                text: "Gas",
                                color: isSelectedFuel == 2
                                    ? KColors.secondaryGreen
                                    : Colors.grey.shade200,
                                textColor: isSelectedFuel == 2
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                                iconColor: isSelectedFuel == 2
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    padding: EdgeInsets.all(10.w),
                    height: 120.h,
                    width: mediaQuery.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: KColors.primaryGrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select your quantity",
                            style: textTheme.bodyMedium,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(6.w),
                          padding: EdgeInsets.all(16.w),
                          width: mediaQuery.width,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: KColors.primaryWhite,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(40.r),
                              right: Radius.circular(40.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _litres != null
                                        ? "$_litres Litres"
                                        : "Loading...",
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: KColors.primaryBlack),
                                  ),
                                  VerticalDivider(
                                    color: KColors.primaryBlack,
                                    thickness: 2,
                                    width: 10.w,
                                  ),
                                  Text(
                                    _price != null ? "\$$_price" : "Loading...",
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: KColors.primaryBlack),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //next
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    padding: EdgeInsets.all(10.w),
                    height: 120.h,
                    width: mediaQuery.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: KColors.primaryGrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Select the number of quantity",
                            style: textTheme.bodyMedium,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(6.w),
                          padding: EdgeInsets.all(16.w),
                          width: mediaQuery.width,
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: KColors.primaryWhite,
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(40.r),
                              right: Radius.circular(40.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Selected: $_selectedQuantity',
                                    style: textTheme.bodyMedium,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(6.w),
                                    width: 125.w,
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: KColors.primaryGrey,
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20.r),
                                        right: Radius.circular(20.r),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: SizedBox(
                                        width: 4.w,
                                        child: DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          value: _selectedQuantity,
                                          items: _choices.map((choice) {
                                            return DropdownMenuItem<String>(
                                              value: choice,
                                              child: Center(
                                                child: Text(
                                                  choice,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedQuantity = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.h),
                  padding: EdgeInsets.all(10.w),
                  height: 100.h,
                  width: mediaQuery.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: KColors.primaryWhite,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(6.w),
                    padding: EdgeInsets.all(10.w),
                    width: mediaQuery.width,
                    decoration: BoxDecoration(
                      color: KColors.primaryGrey,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20.r),
                        right: Radius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.av_timer_outlined,
                              size: 25.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Delivery Time ",
                                      style: textTheme.bodySmall),
                                  Text("20m 35s",
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: KColors.secondaryGreen)),
                                ],
                              ),
                            ),
                            VerticalDivider(
                              color: KColors.primaryBlack,
                              thickness: 2,
                              width: 10.w,
                            ),
                            Icon(
                              Icons.location_on_outlined,
                              size: 25.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Distance", style: textTheme.bodySmall),
                                  Text("07km 20m",
                                      style: textTheme.bodyLarge!.copyWith(
                                          color: KColors.secondaryGreen)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.h, left: 20.w, right: 20.w, bottom: 4.h),
                  child: CustomElevatedButton(
                    label: "Continue",
                    onTap: _sendOrderToFirestore,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.h, left: 20.w, right: 20.w, bottom: 20.h),
                  child: CustomElevatedButton(
                    label: "Back",
                    onTap: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
