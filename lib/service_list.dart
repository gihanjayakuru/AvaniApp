import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          MergedData formData = savedServiceFormData[index];
          return Card(
            child: ListTile(
              title: Text(formData.location),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('serviceType: ${formData.serviceType}'),
                  Text('serviceDescription: ${formData.serviceDescription}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
