import 'dart:convert';

import 'package:reavaya_app/model/manager_user.dart';

import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  static Future<void> storeUserInfo(User userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJsonData = jsonEncode(userInfo.toJson());
    await prefs.setString('currentUser', userJsonData);
  }

  static Future<void> storeUserManagerInfo(ManagerUser userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userJsonData = jsonEncode(userInfo.toJson());
    await prefs.setString('currentManagerUser', userJsonData);
  }

  static Future<User?> readUserInfo() async {
    User? currentUserInfo;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfo = prefs.getString('currentUser');
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<ManagerUser?> readUserManagerInfo() async {
    ManagerUser? currentUserInfo;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfo = prefs.getString('currentManagerUser');
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = ManagerUser.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> clearUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
  }

  static Future<void> clearUserManagerInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentManagerUser');
  }
}
