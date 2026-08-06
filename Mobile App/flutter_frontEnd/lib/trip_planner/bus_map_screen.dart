import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../authentication/passengers/edit_account_screen.dart';
import '../pre_home.dart';
import '../userPreferences/current_user.dart';

class BusMapScreen extends StatelessWidget {
  final LatLng busLiveLocation;
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  BusMapScreen({required this.busLiveLocation});


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
        title: const Text('Bus Location'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: busLiveLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('bus'),
            position: busLiveLocation,
          ),
        },
      ),
    );
  }
}
