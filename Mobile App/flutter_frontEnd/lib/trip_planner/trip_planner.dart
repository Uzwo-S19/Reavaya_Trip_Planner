import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
import '../authentication/passengers/edit_account_screen.dart';
import '../pre_home.dart';
import '../userPreferences/current_user.dart';

import 'bus_map_screen.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({Key? key}) : super(key: key);

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  GoogleMapPolyline googleMapPolyline =
  GoogleMapPolyline(apiKey: 'AIzaSyCOyYjgQSM-cxkB5nmtvKOeh4cMPAfrc0M');
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  String? selectedPickup;
  String? selectedDestination;

  List<String> pickupPoints = [];
  List<String> destinations = [];
  List<Bus> buses = [];
  LatLng? busLiveLocation;

  Timer? busMovementTimer; // Timer for simulating bus movement
  Random random = Random(); // Random number generator

  dynamic data; // Declare the data variable at a higher scope

  Set<Polyline> mapPolylines = {}; // Initialize with an empty set

  @override
  void initState() {
    super.initState();
    fetchPickupPoints();
    fetchDestinations();
    selectedPickup = pickupPoints.isNotEmpty ? pickupPoints[0] : null;
    selectedDestination = destinations.isNotEmpty ? destinations[0] : null;

    // Start simulating bus movement after fetching bus data
    busMovementTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (busLiveLocation != null) {
        simulateBusMovement();
      }
    });
  }



  // Function to simulate bus movement with random coordinates
  // Function to simulate bus movement with random coordinates
  void simulateBusMovement() {
    const double moveDelta = 0.0001; // Adjust the delta as needed
    final double newLatitude = busLiveLocation!.latitude + (random.nextDouble() * 2 - 1) * moveDelta;
    final double newLongitude = busLiveLocation!.longitude + (random.nextDouble() * 2 - 1) * moveDelta;

    setState(() {
      busLiveLocation = LatLng(newLatitude, newLongitude);
    });
  }



  @override
  void dispose() {
    // Cancel the timer when the screen is disposed
    busMovementTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchAndDrawRoute(
      LatLng pickupCoordinates, LatLng destinationCoordinates) async {
    List<LatLng> polylineCoordinates =
        await googleMapPolyline.getCoordinatesWithLocation(
          origin: pickupCoordinates,
          destination: destinationCoordinates,
          mode: RouteMode.driving,
        ) ?? [];

    setState(() {
      mapPolylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
        ),
      );
    });
  }

  Future<void> fetchBuses(String pickup, String destination) async {
    final response = await http.get(
      Uri.parse(
          '${API.fetchCoordinates}?pickup=$pickup&destination=$destination'),
    );
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      print('Received data: $data'); // Print the received data for debugging
      final Map<String, dynamic> pickupCoordinates = data['pickupCoordinates'];
      final Map<String, dynamic> destinationCoordinates =
      data['destinationCoordinates'];

      try {
        final double pickupLatitude =
        double.parse(pickupCoordinates['latitude']);
        final double pickupLongitude =
        double.parse(pickupCoordinates['longitude']);
        final double destinationLatitude =
        double.parse(destinationCoordinates['latitude']);
        final double destinationLongitude =
        double.parse(destinationCoordinates['longitude']);

        drawRouteOnMap(
          LatLng(pickupLatitude, pickupLongitude),
          LatLng(destinationLatitude, destinationLongitude),
        );
      } catch (e) {
        print('Error parsing coordinates: $e'); // Print any parsing errors for debugging
      }
    }
  }

  void drawRouteOnMap(LatLng pickupCoordinates, LatLng destinationCoordinates) {
    setState(() {
      mapPolylines.clear(); // Clear previous polylines
    });

    fetchAndDrawRoute(pickupCoordinates, destinationCoordinates);
  }

  Future<void> fetchPickupPoints() async {
    final response =
    await http.get(Uri.parse(API.pickupPoints));
    if (response.statusCode == 200) {
      setState(() {
        pickupPoints = (json.decode(response.body) as List<dynamic>)
            .cast<String>();
      });
    }
  }

  Future<void> fetchDestinations() async {
    final response = await http
        .get(Uri.parse(API.destinations));
    if (response.statusCode == 200) {
      setState(() {
        destinations = (json.decode(response.body) as List<dynamic>)
            .cast<String>();
      });
    }
  }

  void _onPickupChanged(String? newValue) {
    setState(() {
      selectedPickup = newValue;
    });
  }

  void _onBusTapped(LatLng location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusMapScreen(busLiveLocation: location),
      ),
    );

    fetchAndDrawRoute(busLiveLocation!, location);
  }

  void _onDestinationChanged(String? newValue) {
    setState(() {
      selectedDestination = newValue;
    });
  }

  void _navigateToLoginScreen(BuildContext context) {
    // Call the logout method and navigate back to the Login screen
    CurrentUser().logout();
    _rememberCurrentUser.updateUserInfo();
    Get.to(PreHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: Image.asset(
          'images/Logo.png',
          height: 30,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(EditAccountScreen(user: _rememberCurrentUser.user));
            },
            icon: const Icon(Icons.account_box),
          ),
          ElevatedButton(
            onPressed: () => _navigateToLoginScreen(context),
            child: const Text('Logout',),
          ),
        ],
        title: const Text('Destination Selector'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Choose your pickup point:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedPickup,
              onChanged: _onPickupChanged,
              items: pickupPoints.map((String pickup) {
                return DropdownMenuItem<String>(
                  value: pickup,
                  child: Text(pickup),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose your destination:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedDestination,
              onChanged: _onDestinationChanged,
              items: destinations.map((String destination) {
                return DropdownMenuItem<String>(
                  value: destination,
                  child: Text(destination),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedPickup != null && selectedDestination != null) {
                  await fetchBuses(selectedPickup!, selectedDestination!);

                  if (data != null && data['buses'] != null) {
                    setState(() {
                      // Update the buses list after fetching data
                      buses = (data['buses'] as List<dynamic>)
                          .map<Bus>((bus) => Bus.fromJson(bus))
                          .toList();
                    });
                  }
                }
              },
              child: const Text('Search Buses'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  if (buses.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: buses.length,
                        itemBuilder: (context, index) {
                          final bus = buses[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text('Bus Name: ${bus.name}'),
                              subtitle: Text('Departure Time: ${bus.departureTime}'),
                              onTap: () {
                                setState(() {
                                  _onBusTapped(const LatLng(-26.1820, 27.9992)); // Example coordinates   -26.182097529735366, 27.999245150029786
                                });
                              },
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Center(
                      child: Text(
                        buses.isEmpty ? 'No buses found.' : '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  if (busLiveLocation != null)
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: busLiveLocation!,
                          zoom: 14,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('bus'),
                            position: busLiveLocation!,
                          ),
                        },
                      ),
                    )
                  else
                    const Center(
                      child: Text('Bus location not available'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bus {
  final String name;
  final String departureTime;

  Bus({required this.name, required this.departureTime});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      name: json['name'],
      departureTime: json['departureTime'],
    );
  }
}
