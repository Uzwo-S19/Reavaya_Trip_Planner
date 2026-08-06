import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../authentication/passengers/edit_account_screen.dart';
import '../pre_home.dart';
import '../userPreferences/current_user.dart';

import '../api_connection/api_connection.dart';

class SecondScanPage extends StatefulWidget {

  @override
  State<SecondScanPage> createState() => _SecondScanPageState();
}

class _SecondScanPageState extends State<SecondScanPage> {
  String result = '';
  String? firstScanData; // Variable to store data from the first scan
  String? secondScanData; // Variable to store data from the second scan
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  Future<void> _scanQR() async {
    // Request camera permission
    if (await Permission.camera.request().isGranted) {
      try {
        String? cameraScanResult = await scanner.scan();
        setState(() {
          result = cameraScanResult!; // setting string result with cameraScanResult
         // print(result);
          if (firstScanData == null) {
            firstScanData = result;
           // print("First Scan Data: $firstScanData");
          } else {
            secondScanData = result;
           // print("Second Scan Data: $secondScanData");
            _sendQRCodeToServer();
            if (secondScanData != null) {
              // If both scans are complete, show payment successful message
              _showPaymentSuccessfulDialog();
            }
          }
        });
      } on PlatformException catch (e) {
        print(e);
      }
    } else {
      // Handle permission denial
      print('Camera permission denied');
    }
  }


  // Send the scanned QR code to the server
  Future<void> _sendQRCodeToServer() async {
    if (firstScanData != null && secondScanData != null) {

      try {
        final response = await http.post(Uri.parse(API.qrScanner), body: {
          'firstScannedCode': firstScanData!,
          'secondScannedCode': secondScanData!,
        });

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (response.statusCode == 200) {
          // Server returns the points deducted as a string
          String points = response.body;
          setState(() {
            result = 'QR codes are valid. Points: $points';
          });
          _showPointsDialog(points);
        } else {
          setState(() {
            result = 'Error: Unable to connect to the server.';
          });
        }
      } catch (e) {
        setState(() {
          result = 'Error: $e';
        });
      }
    }
  }

  // Function to show the points in a dialog
  Future<void> _showPointsDialog(String points) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Points Deducted', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('You have been deducted $points points.', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    _showPaymentSuccessfulDialog(); // Show the "Payment Successful" dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // Function to show the payment successful dialog
  Future<void> _showPaymentSuccessfulDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Payment Successful', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Thank you for your payment. Have a safe journey!', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Reset the scanned data to null
                      firstScanData = null;
                      secondScanData = null;
                      result = ''; // Reset the result message
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  /* Function to show a snackbar with a given message
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }*/

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
        title: const Text('Start A Ride'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white, // Set the background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (firstScanData == null)
                const Text(
                  'Please scan the QR code.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )
              else
                const Text(
                  'Have you arrived at your destination? Please scan the Qr code.',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              Text(
                result,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.camera_alt),
        onPressed: () {
          _scanQR(); // calling a function when the user clicks on the button
        },
        label: firstScanData == null ? const Text('Scan') : const Text('Scan'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
