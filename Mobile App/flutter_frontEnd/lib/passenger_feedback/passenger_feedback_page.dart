import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../api_connection/api_connection.dart';
import '../authentication/passengers/edit_account_screen.dart';
import '../home.dart';
import '../userPreferences/current_user.dart';
import 'package:reavaya_app/pre_home.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  int cleanlinessRating = 1;
  int driverRating = 1;
  String comments = '';
  List<int> ratingOptions = [1, 2, 3, 4, 5];

  Future<void> submitFeedback() async {
    try {
      final response = await http.post(
        Uri.parse(API.submitFeedback),
        body: {
          'user_id': _rememberCurrentUser.user.userID.toString(),
          'cleanliness': cleanlinessRating.toString(),
          'driver': driverRating.toString(),
          'comments': comments,
        },
      );

      if (response.statusCode == 200) {
        // Feedback submitted successfully
        // You can show a confirmation message here
        var resBody = jsonDecode(response.body);
        if (resBody['success']) {
          Fluttertoast.showToast(msg: 'Feedback Submitted Successfully');
          //go to home screen
          Get.to(HomePage());
        } else {
          Fluttertoast.showToast(msg: 'An Error Occurred. Try again.');
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Feedback Status not 200: ${response.statusCode}');
      }
    } catch (e) {
      print('ErrorFeedback:: $e');
      Fluttertoast.showToast(msg: 'ErrorFeedback:: $e');
    }
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
        title: const Text('Passenger Feedback'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [

                //Register screen sign-in form
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.all(
                        Radius.circular(60),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                      child: Column(
                        children: [
                          const Text('Rate your experience and give feedback', style: TextStyle(fontSize: 20, color: Colors.black),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Rate Bus Cleanliness: ',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              DropdownButton<int>(
                                value: cleanlinessRating,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    cleanlinessRating = newValue!;
                                  });
                                },
                                items: ratingOptions.map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Rate The Driver: ',
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                              DropdownButton<int>(
                                value: driverRating,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    driverRating = newValue!;
                                  });
                                },
                                items: ratingOptions.map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              hintText: 'comments...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white60,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (value) {
                              setState(() {
                                comments = value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          Material(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                submitFeedback();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 28,
                                ),
                                child: Text(
                                  'Submit Feedback',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void main() {
  runApp(MaterialApp(home: FeedbackPage()));
}
