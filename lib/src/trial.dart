import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Locations and Find Closest',
      home: MapScreen1(),
    );
  }
}

class MapScreen1 extends StatefulWidget {
  @override
  _MapScreen1State createState() => _MapScreen1State();
}

class _MapScreen1State extends State<MapScreen1> {
  GoogleMapController? mapController;
  List<Marker> markers = [];
  LatLng? userLocation;
  static const LatLng initialLocation =
      LatLng(37.7749, -122.4194); // San Francisco

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    setState(() {
      userLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: userLocation!,
          zoom: 14.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarker(LatLng position) {
    if (markers.length < 5) {
      setState(() {
        markers.add(
          Marker(
            markerId: MarkerId(markers.length.toString()),
            position: position,
          ),
        );
      });
    }
  }

  double _calculateDistance(LatLng pos1, LatLng pos2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((pos2.latitude - pos1.latitude) * p) / 2 +
        cos(pos1.latitude * p) *
            cos(pos2.latitude * p) *
            (1 - cos((pos2.longitude - pos1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  void _findClosestLocation() {
    if (markers.isEmpty || userLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please add at least one marker and ensure user location is available.'),
        ),
      );
      return;
    }

    LatLng closestLocation = markers[0].position;
    double closestDistance = _calculateDistance(userLocation!, closestLocation);

    for (int i = 1; i < markers.length; i++) {
      double distance = _calculateDistance(userLocation!, markers[i].position);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestLocation = markers[i].position;
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'The closest location is: ${closestLocation.latitude}, ${closestLocation.longitude} with a distance of ${closestDistance.toStringAsFixed(2)} km'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Locations and Find Closest'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 10.0,
            ),
            markers: Set.from(markers),
            onTap: _addMarker,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: _findClosestLocation,
              child: Text('Find Closest Location'),
            ),
          ),
        ],
      ),
    );
  }
}
