import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../api_connection/api_connection.dart';
import '../../home.dart';
import '../../model/user.dart';
import 'package:http/http.dart' as http;

import '../../userPreferences/current_user.dart';
import 'login_screen.dart';

class EditAccountScreen extends StatefulWidget {
  final User user;

  EditAccountScreen({required this.user});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final HomeController controller = Get.find();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final isObsecure = true.obs;
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing user data
    nameController.text = _rememberCurrentUser.user.userName;
    surnameController.text = _rememberCurrentUser.user.surname;
    emailController.text = _rememberCurrentUser.user.email;
    phoneNoController.text = _rememberCurrentUser.user.phoneNo.toString();
    ageController.text = _rememberCurrentUser.user.phoneNo.toString();
  }

  void updateAccount() async {
    String userInfo =
        '${_rememberCurrentUser.user.userID},${nameController.text.trim()},${surnameController.text.trim()},${emailController.text.trim()},${phoneNoController.text.trim()},${_rememberCurrentUser.user.pointsBalance}';

    // Generate the QR code as a string
    String qrCodeString = base64Encode(utf8.encode(userInfo));

    // Create a new User object with the updated data
    User updatedUser = User(
      _rememberCurrentUser.user.userID,
      nameController.text.trim(),
      surnameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      int.parse(phoneNoController.text.trim()),
      int.parse(ageController.text.trim()),
      _rememberCurrentUser.user.pointsBalance,
      _rememberCurrentUser.user.createdAt,
      _rememberCurrentUser.user.isActive,
      DateTime.now(),
      _rememberCurrentUser.user.lastLogin,
      qrCodeString,
    );

    if(cpasswordController.text.trim() == passwordController.text.trim()){
      try {
        var res = await http.post(
          Uri.parse(API.updateAccount),
          body: updatedUser.toJson(),
        );

        if (res.statusCode == 200) {
          // Connection success
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: 'Account updated successfully');
            // Navigate back to the previous screen
            Get.back();
          } else {
            Fluttertoast.showToast(msg: 'Failed to update account. Try again.');
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Update account status not 200: ${res.statusCode}');
        }
      } catch (e) {
        print('ErrorUpdate:: $e');
        Fluttertoast.showToast(msg: 'ErrorUpdate:: $e');
      }
    }else{
      Fluttertoast.showToast(msg: "Passwords don't match.");
    }
  }

  void _navigateToLoginScreen(BuildContext context) {
    // Call the logout method and navigate back to the Login screen
    CurrentUser().logout();
    _rememberCurrentUser.updateUserInfo();
    Get.to(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
        title: const Text('Edit Account'),
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
                          //registering
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 18,
                                ),

                                //name
                                TextFormField(
                                  controller: nameController,
                                  validator: (val) {
                                    if (val == '') {
                                      return 'Please enter name';
                                    }
                                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(val.toString())) {
                                      return 'Name can only contain alphabets';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: 'name...',
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

                                const SizedBox(
                                  height: 18,
                                ),

                                //surname
                                TextFormField(
                                  controller: surnameController,
                                  validator: (val) {
                                    if (val == '') {
                                      return 'Please enter surname';
                                    }
                                    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(val.toString())) {
                                      return 'Surname can only contain alphabets';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Surname',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                    hintText: 'surname...',
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

                                const SizedBox(
                                  height: 18,
                                ),

                                //email
                                TextFormField(
                                  controller: emailController,
                                  validator: (val) =>
                                  val == '' ? 'Please enter email' : null,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    hintText: 'email...',
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

                                const SizedBox(
                                  height: 18,
                                ),

                                //phone number
                                TextFormField(
                                  controller: phoneNoController,
                                  validator: (val) {
                                    if (val == '') {
                                      return 'Please enter phone number';
                                    }
                                    if (int.tryParse(val.toString()) == null) {
                                      return 'Phone number must be a valid number';
                                    }
                                    if (val?.length != 10) {
                                      return 'Phone number must have exactly 10 digits';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    ),
                                    hintText: 'phone number...',
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

                                const SizedBox(
                                  height: 18,
                                ),

                                //age
                                TextFormField(
                                  controller: ageController,
                                  validator: (val) {
                                    if (val == '') {
                                      return 'Please enter age';
                                    }
                                    if (int.tryParse(val.toString()) == null) {
                                      return 'Age must be a valid number';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Age',
                                    prefixIcon: const Icon(
                                      Icons.numbers,
                                      color: Colors.black,
                                    ),
                                    hintText: 'age...',
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

                                const SizedBox(
                                  height: 18,
                                ),

                                //password
                                Obx(
                                      () => TextFormField(
                                    controller: passwordController,
                                    obscureText: isObsecure.value,
                                    validator: (val) => val == ''
                                        ? 'Please enter password'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Obx(
                                            () => GestureDetector(
                                          onTap: () {
                                            isObsecure.value =
                                            !isObsecure.value;
                                          },
                                          child: Icon(
                                            isObsecure.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      hintText: 'password...',
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
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 18,
                                ),

                                //confirm password
                                Obx(
                                      () => TextFormField(
                                    controller: cpasswordController,
                                    obscureText: isObsecure.value,
                                    validator: (val) => val == ''
                                        ? 'Please enter password'
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Obx(
                                            () => GestureDetector(
                                          onTap: () {
                                            isObsecure.value =
                                            !isObsecure.value;
                                          },
                                          child: Icon(
                                            isObsecure.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      hintText: 'confirm password...',
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
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 18,
                                ),

                                //button
                                Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                  child: InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        //validate user input
                                        updateAccount();
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 28,
                                      ),
                                      child: Text(
                                        'Edit Account',
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
