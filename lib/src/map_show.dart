import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shell Stations',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _stations = [];
  Set<Marker> _markers = Set<Marker>();
  late GoogleMapController _mapController;

  Future<void> _fetchStations() async {
    // Replace 'your_api_key' with your actual API key
    final response = await http.get(Uri.parse(
        "https://www.shell.us/motorist/stateescape.html?api_key=AIzaSyBW9zuVeFJI4WCx-904tuI1X04EzvJo_DI"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _stations = data;
        _setMarkers();
      });
    } else {
      // handle API errors
      print(response.statusCode);
    }
  }

  void _setMarkers() {
    Set<Marker> markers = {};
    for (var station in _stations) {
      // Assuming each station entry has 'latitude' and 'longitude' fields
      final lat = station['latitude'];
      final lng = station['longitude'];
      final stationName = station['station_name'];
      markers.add(Marker(
        markerId: MarkerId(stationName),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: stationName),
      ));
    }
    setState(() {
      _markers = markers;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchStations();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shell Stations'),
          bottom: TabBar(
            tabs: [
              Tab(text: "List"),
              Tab(text: "Shell"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: _stations.length,
              itemBuilder: (context, index) {
                // Assuming each station entry has a 'station_name' field
                final stationName = _stations[index]['station_name'];
                return ListTile(
                  title: Text(stationName),
                );
              },
            ),
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Default to San Francisco
                zoom: 10,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ],
        ),
      ),
    );
  }
}
