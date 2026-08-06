import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:reavaya_app/Constants/key.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_connection/api_connection.dart';
import '../authentication/passengers/edit_account_screen.dart';
import '../pre_home.dart';
import '../userPreferences/current_user.dart';

class MakePayment {
  MakePayment(
      {required this.ctx, required this.price, required this.pointsToAdd});

  BuildContext ctx;
  int price;
  int pointsToAdd;
  PaystackPlugin paystack = PaystackPlugin();

  Future<void> increasePoints() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    if (userId != 0) {
      int userId = prefs.getInt('userId') ?? 0;
      //print('Transaction successful');
      print('UserID: $userId, PointsToAdd: $pointsToAdd');
      try {
        final response = await http.post(
          Uri.parse(API.updatePoints),
          body: {
            'points_balance': pointsToAdd.toString(), // Convert to String
            'user_id': userId.toString(), // Convert to String
          },
        );

        if (response.statusCode == 200) {
          print('Response from server: ${response.body}');
          showDialog(
            context: ctx,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Purchase Successful'),
                content: Text('You have bought $pointsToAdd points'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          print(
              'Failed to add points, HTTP status code: ${response.statusCode}');
          print('Response body: ${response.body}');
          // int userId = prefs.getInt('userId') ?? 0;
          // print('Transaction successful');
          // print('UserID: $userId, PointsToAdd: $pointsToAdd');
          //  print(
          //    'Failed to add points, HTTP status code: ${response.statusCode}');
        }
      } catch (e) {
        print('An error occurred: $e');
      }
    } else {
      print('No logged-in user found');
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('userEmail') ?? '';
    if (email.isEmpty) {
      print('No email found in shared preferences');
      return;
    }

    initializePlugin().then((_) async {
      Charge charge = Charge()
        ..amount = price * 100
        ..email = email
        ..reference = _getReference()
        ..card = _getCardUI()
        ..currency = 'ZAR';

      CheckoutResponse response = await paystack.checkout(
        ctx,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
      );

      print('Response $response');

      if (response.status == true) {
        int userId = prefs.getInt('userId') ?? 0;
        print('Transaction successful');
        print('UserID: $userId, PointsToAdd: $pointsToAdd');

        increasePoints();
      } else {
        print('Transaction failed');
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
  int? selectedIndex;
  int price = 0;
  int points = 0;
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  final plans = [
    {'price': 100, 'points': 100},
    {'price': 200, 'points': 200},
    {'price': 300, 'points': 300},
    {'price': 400, 'points': 400},
  ];

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
            Container(
              alignment: Alignment.center,
              child: const Text(
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
                        points = data['points']!; // added this line
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
                    price: price,
                    pointsToAdd: points,
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
    );
  }
}