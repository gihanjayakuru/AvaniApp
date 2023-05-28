import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_list.dart';
import 'service_data.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  List<MergedData> savedServiceFormData = [];
  // List<MergedData> savedMergedData = [];

  @override
  void initState() {
    super.initState();
    _loadServiceFormData();
  }

  void _loadServiceFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedServiceFormDataJson = prefs.getString('savedServiceFormData');

    if (savedServiceFormDataJson != null) {
      List<dynamic> serviceFormDataList = jsonDecode(savedServiceFormDataJson);
      savedServiceFormData = serviceFormDataList
          .map((formDataJson) => MergedData.fromJson(formDataJson))
          .toList();
    }

    setState(() {
      // Trigger a rebuild to display the retrieved data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service List Screen'),
      ),
      body: ListView.builder(
        itemCount: savedServiceFormData.length,
        itemBuilder: (context, index) {
          MergedData serviceFormData = savedServiceFormData[index];
          return Card(
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('location: ${serviceFormData.location}'),
                  Text('serviceType: ${serviceFormData.serviceType}'),
                  Text(
                      'serviceDescription: ${serviceFormData.serviceDescription}')
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Set the index of the current screen
        onTap: (int index) {
          if (index == 0) {
            // Navigate to HomeScreen
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
            // Navigate to LocationListScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LocationListScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'LocationList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ServiceList',
          ),
        ],
      ),
    );
  }
}
