import 'package:get/get.dart';
import 'package:reavaya_app/userPreferences/user_preferences.dart';

import '../model/manager_user.dart';
import '../model/user.dart';

class CurrentUser extends GetxController {
  final Rx<User> _currentUser = User(
    0,
    '',
    '',
    '',
    '',
    0,
    0,
    0,
    DateTime.timestamp(),
    0,
    DateTime.timestamp(),
    DateTime.timestamp(),
    '',
  ).obs;
  User get user => _currentUser.value;

  final Rx<ManagerUser> _currentManagerUser = ManagerUser(
    0,
    '',
    '',
    '',
    '',
    0,
    '',
    DateTime.timestamp(),
    0,
    DateTime.timestamp(),
    DateTime.timestamp(),
    '',
  ).obs;
  ManagerUser get managerUser => _currentManagerUser.value;

  getUserInfo() async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }

  void logout() async {
    // Clear the current user info from SharedPreferences
    await RememberUserPrefs.clearUserInfo();
    _currentUser.value = User(0, '', '', '', '', 0, 0, 0, DateTime.now(), 0,
      DateTime.now(), DateTime.now(), '',);
  }

  void updateUserInfo() {
    getUserInfo();
  }

  getManagerUserInfo() async {
    ManagerUser? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserManagerInfo();
    _currentManagerUser.value = getUserInfoFromLocalStorage!;
  }

  void logoutManager() async {
    // Clear the current user info from SharedPreferences
    await RememberUserPrefs.clearUserManagerInfo();
    _currentManagerUser.value = ManagerUser(0, '', '', '', '', 0, '', DateTime.now(), 0,
      DateTime.now(), DateTime.now(), '',);
  }

  void updateManagerUserInfo() {
    getManagerUserInfo();
  }
}
