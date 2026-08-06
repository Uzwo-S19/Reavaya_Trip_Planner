import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../api_connection/api_connection.dart';
import '../../model/user.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNoController = TextEditingController();
  var ageController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'email': emailController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        //connection success
        var resBody = jsonDecode(res.body);
        if (resBody['emailFound']) {
          Fluttertoast.showToast(
              msg: 'Email already in use. Try another email.');
        } else {
          registerUser();
        }
      } else {
        Fluttertoast.showToast(msg: 'Email Status not 200: ${res.statusCode}');
      }
    } catch (e) {
      print('ErrorEmail:: $e');
      Fluttertoast.showToast(msg: 'ErrorEmail:: $e');
    }
  }

  registerUser() async {
    String userInfo =
        '${1},${nameController.text.trim()},${surnameController.text.trim()},${emailController.text.trim()},${phoneNoController.text.trim()},${0}';

    // Generate the QR code as a string
    String qrCodeString = base64Encode(utf8.encode(userInfo));

    User userModel = User(
      1,
      nameController.text.trim(),
      surnameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
      int.parse(phoneNoController.text.trim()),
      int.parse(ageController.text.trim()),
      0,
      DateTime.now(), // Format created_at to string
      1,
      DateTime.now(), // Format updated_at to string
      DateTime.now(), // Format last_login to string
      qrCodeString, // Store the generated QR code as a string in the User object
    );

    if(cpasswordController.text.trim() == passwordController.text.trim()){
      try {
        var res = await http.post(
          Uri.parse(API.register),
          body: userModel.toJson(),
        );

        if (res.statusCode == 200) {
          //connection success
          var resBody = jsonDecode(res.body);
          if (resBody['success']) {
            Fluttertoast.showToast(msg: 'Registered Successfully');
            API.counter++;
            //go to login screen
            Get.to(LoginScreen());
          } else {
            Fluttertoast.showToast(msg: 'An Error Occurred. Try again.');
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Register Status not 200: ${res.statusCode}');
        }
      } catch (e) {
        print('ErrorRegister:: $e');
        Fluttertoast.showToast(msg: 'ErrorRegister:: $e');
      }
    }else{
      Fluttertoast.showToast(msg: "Passwords don't match.");
    }
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
          ElevatedButton(
            onPressed: () {
              Get.to(LoginScreen());
            },
            child: const Text('Login'),
          ),
        ],
        title: const Text('Register'),
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
                                        //validate user email
                                        validateUserEmail();
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

                          const SizedBox(
                            height: 16,
                          ),

                          //account text button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Get.to(LoginScreen());
                                },
                                child: const Text(
                                  'Click here',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /*const Text(
                            'Or',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),

                          //manager
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Are you a Manager?'),
                              TextButton(
                                onPressed: () {
                                  Get.to(RegisterManagerScreen());
                                },
                                child: const Text(
                                  'Register here',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),*/
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
