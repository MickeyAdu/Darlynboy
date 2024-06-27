import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
    required this.location,
  }) : super(key: key);

  final String location;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LatLng? _currentPosition;
  LatLng? _fetchedPosition;
  Set<Marker> _markers = {};
  Polyline? _polyline;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchLocationFromFirestore();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Request location service to be enabled
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        // Permission denied, handle it
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit:
            const Duration(seconds: 10), // Set a timeout for location fetch
      );
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _addMarker(_currentPosition!, "Current Location", true);
      });
    } catch (e) {
      // Handle location fetch error
      print("Error getting location: $e");
    }
  }

  Future<void> _fetchLocationFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return;
    }
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Customer_Details')
          .where('user_ID', isEqualTo: user.uid)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        var data = documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('location')) {
          String location = data['location'];
          var locations = await locationFromAddress(location);
          if (locations.isNotEmpty) {
            setState(() {
              _fetchedPosition =
                  LatLng(locations[0].latitude, locations[0].longitude);
              _addMarker(_fetchedPosition!, "Fetched Location", false);
              _drawPolyline();
            });
            _calculateAndSaveDistance();
          }
        } else {
          print('Location not found in document');
        }
      } else {
        print('No documents found');
      }
    } catch (e) {
      print("Error fetching location from Firestore: $e");
    }
  }

  void _addMarker(LatLng position, String title, bool isCurrentLocation) {
    _markers.add(Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: title),
      icon: isCurrentLocation
          ? BitmapDescriptor.defaultMarker
          : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));
  }

  void _drawPolyline() {
    if (_currentPosition != null && _fetchedPosition != null) {
      setState(() {
        _polyline = Polyline(
          polylineId: PolylineId('route'),
          points: [_currentPosition!, _fetchedPosition!],
          color: Colors.blue,
          width: 5,
        );
      });
    }
  }

  Future<void> _calculateAndSaveDistance() async {
    if (_currentPosition != null && _fetchedPosition != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        _fetchedPosition!.latitude,
        _fetchedPosition!.longitude,
      );

      await _firestore.collection('route_distances').add({
        'start_latitude': _currentPosition!.latitude,
        'start_longitude': _currentPosition!.longitude,
        'end_latitude': _fetchedPosition!.latitude,
        'end_longitude': _fetchedPosition!.longitude,
        'distance_in_meters': distanceInMeters,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                    onMapCreated: (controller) {
                      _controller = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 14,
                    ),
                    markers: _markers,
                    polylines: _polyline != null ? {_polyline!} : {},
                  ),
          ),
        ],
      ),
    );
  }
}

class OrderData {
  final String id;
  final String status;

  OrderData({required this.id, required this.status});

  factory OrderData.fromFirestore(Map<String, dynamic> data) {
    return OrderData(
      id: data['id'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
