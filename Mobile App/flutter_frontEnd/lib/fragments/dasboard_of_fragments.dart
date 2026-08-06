import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reavaya_app/userPreferences/current_user.dart';

class DashboardOfFragments extends StatelessWidget {
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentUser){
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller){
        return const Scaffold(

        );
      },
    );
  }
}
