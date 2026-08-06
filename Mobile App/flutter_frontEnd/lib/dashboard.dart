import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reavaya_app/pre_home.dart';
import 'package:reavaya_app/userPreferences/current_user.dart';
import 'authentication/managers/edit_manager_account_screen.dart';
import 'manager_statistics/statistics_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reavaya App',
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

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

  void _navigateToLoginScreen(BuildContext context) {
    // Call the logout method and navigate back to the Login screen
    CurrentUser().logoutManager();
    _rememberCurrentUser.updateManagerUserInfo();
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
              Get.to(EditManagerAccountScreen(user: _rememberCurrentUser.managerUser));
            },
            icon: const Icon(Icons.account_box),
          ),
          ElevatedButton(
            onPressed: () => _navigateToLoginScreen(context),
            child: const Text('Logout',),
          ),
        ],
        title: const Text('Dashboard'),
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
                  color: Colors.black,
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

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Get.to(StatisticsPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Check Statistics'),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('Add Notices'),
              ),

              const SizedBox(height: 16),

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
