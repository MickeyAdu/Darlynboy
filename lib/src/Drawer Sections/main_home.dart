import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mic_fuel/src/choice_page.dart';
import 'package:mic_fuel/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  Location location = Location();
  final LatLng _initialPosition = LatLng(6.6731, -1.5637);

  // List of fuel stations
  final List<String> fuelStations = [
    "Total Fuel Station",
    "Shell Fuel Station",
    "Goil Fuel Station",
    "Petrosol Fuel Station"
  ];

  // Initialize the selection state for each item
  List<bool> isSelectedList;
  int? _selectedStationIndex;

  String _selectedFuelType = "petrol";
  double? _litres;
  double? _price;
  int? selectedButtonIndex;

  void _onStationTap(int index) {
    setState(() {
      _selectedStationIndex = index;
      fetchLitreAndPrice();
    });
  }

  _HomeScreenState() : isSelectedList = List.generate(4, (index) => index == 0);
  int? isSelectedFuel;
  @override
  void initState() {
    super.initState();
    fetchLitreAndPrice();
  }

  Future<void> fetchLitreAndPrice() async {
    if (_selectedStationIndex == null) return;

    String stationId;
    switch (_selectedStationIndex) {
      case 0:
        stationId = "fuel_station_id_1"; // replace with actual station IDs
        break;
      case 1:
        stationId = "fuel_station_id_2"; // replace with actual station IDs
        break;
      case 2:
        stationId = "fuel_station_id_3"; // replace with actual station IDs
        break;
      case 3:
        stationId = "fuel_station_id_4"; // replace with actual station IDs
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
        _litres = fuelData['litres'];
        _price = fuelData['price'];
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  //button widget

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition, // Coordinates for New York City
                zoom: 15.0,
              ),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: KColors.primaryWhite,
                backgroundImage: const AssetImage('assets/woman.png'),
              ),
            )
          ],
        ),
        bottomSheet: Container(
          height: 80.h,
          width: mediaQuery.width,
          decoration: BoxDecoration(
            color: KColors.primaryWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          for (int i = 0; i < isSelectedList.length; i++) {
                            isSelectedList[i] = i == index;
                          }
                          _onStationTap(index);
                          fetchLitreAndPrice();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChoicePage(
                                        selectedStationName:
                                            fuelStations[index],
                                      )));
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: isSelectedList[index]
                              ? KColors.primaryOrange
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        width: 210.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Maki.fuel,
                              color: isSelectedList[index]
                                  ? KColors.primaryWhite
                                  : KColors.primaryBlack,
                            ),
                            Text(
                              fuelStations[index],
                              style: textTheme.bodyMedium!.copyWith(
                                color: isSelectedList[index]
                                    ? KColors.primaryWhite
                                    : KColors.primaryBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.w,
                    ),
                    itemCount: fuelStations.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
