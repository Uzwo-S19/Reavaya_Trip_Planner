import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:reavaya_app/Constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:reavaya_app/userPreferences/current_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_connection/api_connection.dart';
import '../authentication/passengers/edit_account_screen.dart';
import '../home.dart';
import '../pre_home.dart';

class MakePayment {
  MakePayment(
      {required this.ctx,
      required this.price,
      required this.email,
      required this.pointsToAdd,
      required this.onPointsAdded});

  BuildContext ctx;
  int price;
  String email;
  int pointsToAdd;
  PaystackPlugin paystack = PaystackPlugin();
  Function(int) onPointsAdded;

  Future<void> increasePoints() async {
    // Fetch the user ID from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    // Proceed with the request only if a valid user ID is found
    if (userId != 0) {
      try {
        final response = await http.post(
          Uri.parse(API.updatePoints),
          body: {
            'points': pointsToAdd.toString(),
            'userId': userId.toString(),
          },
        );

        if (response.statusCode == 200) {
          print('Points added successfully');
          onPointsAdded(pointsToAdd);
        } else {
          print('Failed to add points');
        }
      } catch (e) {
        print('An error occurred: $e');
      }
    } else {
      print('No logged-in user found');
      // You can handle the situation here when no logged-in user is found
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardUI() {
    return PaymentCard(number: '', cvc: '', expiryMonth: 0, expiryYear: 0);
  }

  Future initializePlugin() async {
    await paystack.initialize(publicKey: ConstantKey.PAYSTACK_KEY);
  }

  chargeCardAndMakePayment() async {
    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..card = _getCardUI()
        ..currency = 'ZAR';

      // User feedback such as a loading indicator can be initiated here

      CheckoutResponse response = await paystack.checkout(
        ctx,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
      );

      // Stop the loading indicator here

      print('Response $response');

      if (response.status == true) {
        print('Transaction successful');

        // Call the function to increase points
        increasePoints();

        //Send something to database here AND/OR Update the UI
      } else {
        print('Transaction failed');
        // Handle the transaction failure here
      }
    });
  }
}

class PointPurchasePage extends StatefulWidget {
  const PointPurchasePage({Key? key}) : super(key: key);

  @override
  _PointPurchasePageState createState() => _PointPurchasePageState();
}

class _PointPurchasePageState extends State<PointPurchasePage> {
  final HomeController controller = Get.find();

  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  int? selectedIndex;
  int price = 0;
  late String email; // Email of the user
  int points = 0;

  final plans = [
    {'price': 100, 'points': 100},
    {'price': 200, 'points': 200},
    {'price': 300, 'points': 300},
    {'price': 400, 'points': 400},
  ];

  void updatePoints(int pointsAdded) {
    setState(() {
      points += pointsAdded;
    });
  }

  _PointPurchasePageState(){
    email = _rememberCurrentUser.user.email;
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
        title: const Text('Buy Points'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Your current points: $points',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Pick Your Points Plan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                children: List.generate(plans.length, (index) {
                  final data = plans[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        price = data['price']!;
                      });
                    },
                    child: Card(
                      shadowColor: Colors.blueAccent,
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: selectedIndex == null
                              ? null
                              : selectedIndex == index
                                  ? Colors.blueAccent
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "R ${data["price"]}",
                              style: const TextStyle(fontSize: 25),
                            ),
                            Text("Get ${data["points"]} points"),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (selectedIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a plan')),
                  );
                } else {
                  MakePayment(
                    ctx: context,
                    email: email,
                    price: price,
                    pointsToAdd: plans[selectedIndex!]['points'] ?? 0,
                    onPointsAdded: updatePoints, // Include the callback
                  ).chargeCardAndMakePayment();
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.security, color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      'Proceed to payment',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
            icon: Icon(CupertinoIcons.money_dollar),
            label: 'Buy Points',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ], // Use controller's method for onTap
      ),
    );
  }
}
