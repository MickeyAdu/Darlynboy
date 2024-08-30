import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/maki_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mic_fuel/screens/choice_page.dart';
import 'package:mic_fuel/themes/colors.dart';
import 'package:mic_fuel/themes/style.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  // Location location = Location(latitude: 0.0, longitude: 0.0, timestamp: null);
  LatLng _initialPosition = const LatLng(6.6731, -1.5637);
  Set<Marker> _markers = {};
  Position? _currentPosition; // Using the Position type from geolocator
  String _cityName = "Fetching location...";

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
      const LatLng(4.683, -1.165), // Total station 1
      const LatLng(8.993, -2.575),
      const LatLng(12.693, -3.575),
      const LatLng(20.693, -7.575),
      const LatLng(22.693, -1.575),
    ],
    [
      const LatLng(6.672, -1.564), // Shell station 1
      const LatLng(6.681, -1.572),
      const LatLng(1.693, -9.975),
      const LatLng(5.693, -7.575),
      const LatLng(7.693, -4.575),
    ],
    [
      const LatLng(6.675, -1.563), // Goil station 1
      const LatLng(7.688, -8.577),
      const LatLng(8.693, -5.575),
      const LatLng(9.693, -9.575),
      const LatLng(11.693, -2.575),
    ],
    [
      const LatLng(6.459, -2.768), // Petrosol station 1
      const LatLng(5.684, -4.274),
      const LatLng(7.693, -12.775),
      const LatLng(6.693, -51.775),
    ],
  ];

  // Initialize the selection state for each item
  List<bool> isSelectedList;
  int? _selectedStationIndex;

  String _selectedFuelType = "petrol";
  double? _litres;
  double? _price;

  void _onStationTap(int index) async {
    if (!mounted) return;

    setState(() {
      _selectedStationIndex = index;
    });

    await _fetchFuelStations(index);
    await _zoomToClosestStation(index);

    if (!mounted) return;

    bool confirm = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          color: Theme.of(context)
              .colorScheme
              .surface, // Adjust the opacity as needed
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: const Text('Confirm Navigation'),
                textColor: Theme.of(context).colorScheme.primary,
                subtitle:
                    const Text('Do you want to navigate to the next page?'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (!mounted) return;

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
    fetchLocation();
    _fetchFuelStations(0); // Fetch Total stations initially
  }

  Future<void> fetchLocation() async {
    try {
      // Fetch the current location
      Position locationData = await _getCurrentLocation();
      print(
          "Current location: ${locationData.latitude}, ${locationData.longitude}");

      // Convert coordinates to a city name
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude,
        locationData.longitude,
      );

      // Get the city name from the first placemark
      String cityName = placemarks.first.locality ?? "Unknown location";

      setState(() {
        _cityName = cityName; // Update the state to display the city name
      });
      print("City: $cityName"); // Optional: print the city name
    } catch (e) {
      print("Error fetching location or city name: $e");
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition();
  }
  // Future<LocationData> _getCurrentLocation() async {
  //   LocationData currentLocation = await location.getLocation();
  //   setState(() {
  //     _initialPosition =
  //         LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //   });
  //   return currentLocation;
  // }

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
    fetchLocation();

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
    var mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
              padding: EdgeInsets.all(16.w),
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
            color: Theme.of(context).colorScheme.surface,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Maki.fuel,
                              color: isSelectedList[index]
                                  ? KColors.primaryWhite
                                  : KColors.primaryBlack,
                            ),
                            Text(
                              fuelStations[index],
                              style: bodyMedium.copyWith(
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
