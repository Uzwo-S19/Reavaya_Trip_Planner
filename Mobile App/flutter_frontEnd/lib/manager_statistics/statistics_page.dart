import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api_connection/api_connection.dart';
import '../authentication/managers/edit_manager_account_screen.dart';
import '../pre_home.dart';
import '../userPreferences/current_user.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int userCount = 0;
  List<Map<String, dynamic>> loginStatistics = [];
  List<Map<String, dynamic>> demographicData = [];
  final CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  Future<void> fetchData() async {
    final statisticsResponse = await http.get(Uri.parse(API.fetchStatistics));
    final demographicResponse = await http.get(Uri.parse(API.fetchDemographicData));

    if (statisticsResponse.statusCode == 200 && demographicResponse.statusCode == 200) {
      final statisticsData = json.decode(statisticsResponse.body);
      final demographicData = json.decode(demographicResponse.body);

      setState(() {
        userCount = API.counter;
        loginStatistics = statisticsData['loginStatistics'];
        this.demographicData = demographicData;
      });
    }
  }

  @override
  void initState() {
    fetchData();
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
        title: const Text('Dashboard'),
        //centerTitle: true, // Center-align the title
        //iconTheme: const IconThemeData(color: Colors.black), // Adjust the icon color
        //backgroundColor: Colors.white, // Set the background color
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display user count and login statistics as before

            const SizedBox(height: 20),
            const Text('Demographic Insights:'),
            if (demographicData.isNotEmpty) ...[
              _buildAgeDistributionChart(),
              //_buildGenderDistributionChart(),
              // Add more demographic insights as needed
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAgeDistributionChart() {
    final ageData = demographicData.map((entry) => entry['age'] as int).toList();

    // Define age intervals
    final ageIntervals = ['0-20', '21-30', '31-40', '40+'];
    final ageRanges = [20, 30, 40, double.infinity];

    // Count the number of users in each age interval
    final ageCounts = [0, 0, 0, 0];
    for (final age in ageData) {
      for (var i = 0; i < ageRanges.length; i++) {
        if (age <= ageRanges[i]) {
          ageCounts[i]++;
          break;
        }
      }
    }

    return PieChart(
      PieChartData(
        sections: List.generate(
          ageIntervals.length,
              (index) {
            return PieChartSectionData(
              value: ageCounts[index].toDouble(),
              title: '${ageCounts[index]}',
              radius: 50,
              titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }
}
