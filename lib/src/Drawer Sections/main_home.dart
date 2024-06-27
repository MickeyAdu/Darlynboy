import 'dart:math';

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
  LatLng _initialPosition = LatLng(6.6731, -1.5637);
  Set<Marker> _markers = {};

  // List of fuel stations
  final List<String> fuelStations = [
    "Total Fuel Station",
    "Shell Fuel Station",
    "Goil Fuel Station",
    "Petrosol Fuel Station"
  ];

  // Fixed coordinates for different fuel stations
  final List<List<LatLng>> fuelStationsCoordinates = [
    [
      LatLng(6.683, -1.565), // Total station 1
      LatLng(6.693, -1.575), // Total station 2
    ],
    [
      LatLng(6.672, -1.564), // Shell station 1
      LatLng(6.681, -1.572), // Shell station 2
    ],
    [
      LatLng(6.675, -1.563), // Goil station 1
      LatLng(6.688, -1.577), // Goil station 2
    ],
    [
      LatLng(6.679, -1.568), // Petrosol station 1
      LatLng(6.684, -1.574), // Petrosol station 2
    ],
  ];

  // Initialize the selection state for each item
  List<bool> isSelectedList;
  int? _selectedStationIndex;

  String _selectedFuelType = "petrol";
  double? _litres;
  double? _price;

  void _onStationTap(int index) async {
    setState(() {
      _selectedStationIndex = index;
    });
    await _fetchFuelStations(index);
    await _zoomToClosestStation(index);

    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.3),
          title: Text('Confirm Navigation'),
          content: Text('Do you want to navigate to the next page?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (confirm) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChoicePage(
            selectedStationName: fuelStations[index],
          ),
        ),
      );
    }
  }

  _HomeScreenState() : isSelectedList = List.generate(4, (index) => index == 0);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchFuelStations(0); // Fetch Total stations initially
  }

  Future<void> _getCurrentLocation() async {
    LocationData currentLocation = await location.getLocation();
    setState(() {
      _initialPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
    });
  }

  Future<void> _fetchFuelStations(int index) async {
    setState(() {
      _markers.clear();
      BitmapDescriptor markerColor;
      switch (index) {
        case 0:
          markerColor =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
          break;
        case 1:
          markerColor =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
          break;
        case 2:
          markerColor =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
          break;
        case 3:
          markerColor =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
          break;
        default:
          markerColor = BitmapDescriptor.defaultMarker;
      }

      for (var station in fuelStationsCoordinates[index]) {
        _markers.add(
          Marker(
            markerId: MarkerId(station.toString()),
            position: station,
            infoWindow: InfoWindow(title: fuelStations[index]),
            icon: markerColor,
          ),
        );
      }
    });
  }

  Future<void> _zoomToClosestStation(int index) async {
    if (_markers.isEmpty) return;

    LatLng userLocation = _initialPosition;
    Marker? closestMarker;
    double closestDistance = double.infinity;

    // Determine initial marker color based on selected index
    BitmapDescriptor initialMarkerColor;
    switch (index) {
      case 0:
        initialMarkerColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
        break;
      case 1:
        initialMarkerColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
        break;
      case 2:
        initialMarkerColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
        break;
      case 3:
        initialMarkerColor =
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
        break;
      default:
        initialMarkerColor = BitmapDescriptor.defaultMarker;
    }

    for (Marker marker in _markers) {
      double distance = _calculateDistance(
        userLocation.latitude,
        userLocation.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      if (distance < closestDistance) {
        closestDistance = distance;
        closestMarker = marker;
      }
    }

    if (closestMarker != null) {
      setState(() {
        _markers = _markers.map((marker) {
          if (marker.markerId == closestMarker!.markerId) {
            return marker.copyWith(
              iconParam: initialMarkerColor, // Set initial marker color here
            );
          }
          return marker;
        }).toSet();
      });

      await mapController?.animateCamera(CameraUpdate.newLatLngZoom(
        closestMarker.position,
        18.0,
      ));
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Pi/180
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

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
                target: _initialPosition,
                zoom: 15.0,
              ),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
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
