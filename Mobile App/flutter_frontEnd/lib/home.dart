import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reavaya_app/Payment/point_purchase_page.dart';
import 'package:reavaya_app/passenger_feedback/passenger_feedback_page.dart';
import 'package:reavaya_app/pre_home.dart';
import 'package:reavaya_app/qr_scanner/second_scan.dart';
import 'package:reavaya_app/trip_planner/trip_planner.dart';
import 'package:reavaya_app/userPreferences/current_user.dart';
import 'authentication/passengers/edit_account_screen.dart';
import 'manager_notices/manager_notices_screen.dart';

void main() {
  Get.put(CurrentUser());  // Put your CurrentUser instance into the GetX dependency injection system
  Get.put(HomeController()); // Put your HomeController into the GetX dependency injection system
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reavaya App',
      home: HomePage(), // Use HomePage widget as the home
      getPages: [
        GetPage(name: '/pointPurchase', page: () => const PointPurchasePage()),
        // Add more pages if needed
      ],
    );
  }
}

final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
class HomePage extends StatelessWidget {
  //final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  final HomeController controller = Get.find();

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
        title: const Text('Home'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: [
          SingleChildScrollView(
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

                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(const PointPurchasePage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: const Text('Buy Points'),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(SecondScanPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: const Text('Start A Ride'),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(const DestinationScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: const Text('Plan A Trip'),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      Get.to(FeedbackPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: const Text('Give Feedback'),
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
          const PointPurchasePage(),
          const ManagerNoticesScreen(),
          EditAccountScreen(user: _rememberCurrentUser.user),
        ]
      ),


      bottomNavigationBar: CupertinoTabBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        activeColor: CupertinoColors.activeBlue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar_circle),
            label: 'Buy Points',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ], // Use controller's method for onTap
      ),
    );

  }
}

class HomeController extends GetxController {
  var currentIndex = 0.obs;  // Use an observable for reactive updates

  void changePage(int index) {
    print('Changing index from ${currentIndex.value} to $index');
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.to(() => HomePage());  // Replace HomePage() with the actual page you want to navigate to
        break;
      case 1:
        Get.to(() =>const PointPurchasePage());  // Replace BalancePage() with the actual page you want to navigate to
        break;
      case 2:
        Get.to(() =>const ManagerNoticesScreen());  // Replace ProfilePage() with the actual page you want to navigate to
        break;
      case 3:
        Get.to(() =>EditAccountScreen(user: _rememberCurrentUser.user));  // Replace ProfilePage() with the actual page you want to navigate to
        break;
    }// Update the currentIndex
  }
}


