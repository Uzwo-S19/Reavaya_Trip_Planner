import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api_connection/api_connection.dart';
import '../authentication/managers/edit_manager_account_screen.dart';
import '../home.dart';
import '../pre_home.dart';
import '../userPreferences/current_user.dart';

class ManagerNoticesScreen extends StatefulWidget {
  const ManagerNoticesScreen({Key? key}) : super(key: key);

  @override
  State<ManagerNoticesScreen> createState() => _ManagerNoticesScreenState();
}

class _ManagerNoticesScreenState extends State<ManagerNoticesScreen> {
  final HomeController controller = Get.find();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  List<String> recipientEmails = []; // Store user emails here
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  Future<void> fetchUserEmails() async {
    final res = await http.get(Uri.parse(API.fetchUserData));

    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      setState(() {
        recipientEmails = data.map((item) => item['email'] as String).toList();
      });
    } else {
      Fluttertoast.showToast(msg: 'Login Status not 200: ${res.statusCode}');
    }
  }

  Future<void> sendEmail() async {
    final Email email = Email(
      subject: subjectController.text.trim(),
      body: messageController.text.trim(),
      recipients: recipientEmails,
      //cc: [],  // Add CC emails here
      // bcc: [], // Add BCC emails here
    );

    try {
      await FlutterEmailSender.send(email);
      Fluttertoast.showToast(msg: 'Emails sent successfully.');
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Emails sent successfully.')));
    } catch (error) {
      Fluttertoast.showToast(msg: 'Failed to send emails.');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to send emails.')));
      print(error.toString());
    }
  }

  @override
  void initState() {
    fetchUserEmails();
    super.initState();
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
        title: const Text('Send Notices'), // Add the 'Send Notices' title
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: Padding(
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
                TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    prefixIcon: const Icon(
                      Icons.topic,
                      color: Colors.black,
                    ),
                    hintText: 'subject...',
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
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: messageController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    prefixIcon: const Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                    hintText: 'message...',
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
                ),

                const SizedBox(height: 18),
                
                Material(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      sendEmail();
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 28,
                      ),
                      child: Text(
                        'Send Emails',
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

void main() {
  runApp(MaterialApp(
    home: ManagerNoticesScreen(),
  ));
}
