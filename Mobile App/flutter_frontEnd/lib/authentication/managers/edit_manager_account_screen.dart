import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../api_connection/api_connection.dart';
import '../../model/manager_user.dart';
import 'package:http/http.dart' as http;

import '../../userPreferences/current_user.dart';
import 'login_manager_screen.dart';

class EditManagerAccountScreen extends StatefulWidget {
  final ManagerUser user;

  EditManagerAccountScreen({required this.user});

  @override
  State<EditManagerAccountScreen> createState() => _EditManagerAccountScreenState();
}

class _EditManagerAccountScreenState extends State<EditManagerAccountScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final isObsecure = true.obs;
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing user data
    nameController.text = _rememberCurrentUser.managerUser.userName;
    surnameController.text = _rememberCurrentUser.managerUser.surname;
    emailController.text = _rememberCurrentUser.managerUser.email;
    phoneNoController.text = _rememberCurrentUser.managerUser.phoneNo.toString();
    passwordController.text = _rememberCurrentUser.managerUser.password;
  }

  void updateAccount() async {
    // Create a new User object with the updated data
    ManagerUser updatedUser = ManagerUser(
      _rememberCurrentUser.managerUser.userID,
      nameController.text.trim(),
      surnameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      int.parse(phoneNoController.text.trim()),
      _rememberCurrentUser.managerUser.managerID,
      _rememberCurrentUser.managerUser.createdAt,
      _rememberCurrentUser.managerUser.isActive,
      DateTime.now(),
      _rememberCurrentUser.managerUser.lastLogin,
      _rememberCurrentUser.managerUser.qrCode,
    );

    try {
      var res = await http.post(
        Uri.parse(API.updateAccountManager),
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
  }

  void _navigateToLoginScreen(BuildContext context) {
    // Call the logout method and navigate back to the Login screen
    CurrentUser().logoutManager();
    _rememberCurrentUser.updateManagerUserInfo();
    Get.to(LoginManagerScreen());
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
              Get.to(EditManagerAccountScreen(user: _rememberCurrentUser.managerUser));
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
                                  validator: (val) =>
                                  val == '' ? 'Please enter name' : null,
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
                                  validator: (val) =>
                                  val == '' ? 'Please enter surname' : null,
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
                                  validator: (val) => val == ''
                                      ? 'Please enter phone number'
                                      : null,
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
                                        'Register',
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
    );
  }
}
