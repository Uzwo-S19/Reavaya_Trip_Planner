import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reavaya_app/authentication/passengers/register_screen.dart';
import 'authentication/passengers/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: PreHomeScreen(),
    );
  }
}

class PreHomeScreen extends StatelessWidget {
  void _showBusRouteImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Image.asset(
          'images/Official_Rea_Vaya_Route_Map.jpg',
          fit: BoxFit.contain,
        ),
      ),
    );
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
          ElevatedButton(
            onPressed: () {
              Get.to(RegisterScreen());
            },
            child: const Text('Register',),
          ),

          const SizedBox(height: 4),
          ElevatedButton(
            onPressed: () {
              Get.to(LoginScreen());
            },
            child: const Text('Login',),
          ),
        ],
        title: const Text('Home'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Easiest way to catch a ride',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey,
                ),
              ),
              const Text(
                'Ride with us, arrive with ease',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.lightBlueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /*const Text(
                'Rea Vaya is a quick and efficient bus system in Johannesburg, South Africa. It started in 2009 to give people a cheaper, safer, and easier way to travel around the city. Rea Vaya buses have their own special lanes, which makes them faster and more reliable.',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              const Text(
                "The system is designed for everyone in Johannesburg, especially those with lower incomes. It's run by the City of Johannesburg and is an important part of improving transportation and reducing traffic jams.",
                style: TextStyle(fontSize: 16),
              ),*/

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  Get.to(LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                ),
                child: const Text('Start A Ride With Us'),
              ),

              const SizedBox(height: 24),

              const Text(
                '50+',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'stations available',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Our company has developed a map that displays all of our available locations throughout the area, making it easy for potential customers to find us. With detailed information and accurate location markers, users can quickly navigate to any of our establishments.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 24),

              GestureDetector(
                onTap: () => _showBusRouteImage(context),
                child: Image.asset(
                  'images/Official_Rea_Vaya_Route_Map.jpg',
                  height: 285,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
