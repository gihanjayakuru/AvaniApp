import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'additional_details_screen.dart';
import 'form_data.dart';
import 'service_data.dart';

class LocationListScreen extends StatefulWidget {
  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  List<FormData> savedFormData = [];
  FormData? selectedFormData;

  @override
  void initState() {
    super.initState();
    _loadFormData();
    // _loadMergedData();
  }

  void _loadFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedFormDataJson = prefs.getString('savedFormData');

    if (savedFormDataJson != null) {
      List<dynamic> formDataList = jsonDecode(savedFormDataJson);
      savedFormData = formDataList
          .map((formDataJson) => FormData.fromJson(formDataJson))
          .toList();
    }

    setState(() {
      // Trigger a rebuild to display the retrieved data
    });
  }

  // void _loadMergedData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String? savedMergedDataJson = prefs.getString('savedMergedData');

  //   if (savedMergedDataJson != null) {
  //     List<dynamic> mergedDataList = jsonDecode(savedMergedDataJson);
  //     savedMergedData = mergedDataList
  //         .map((mergedDataJson) => MergedData.fromJson(mergedDataJson))
  //         .toList();
  //   }

  //   setState(() {
  //     // Trigger a rebuild to display the retrieved data
  //   });
  // }

  void _showDetailsDialog(BuildContext context, FormData formData, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Additional Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Location: ${formData.location}'),
              SizedBox(height: 8),
              Text('Created: ${formData.createdDate.toString()}'),
              SizedBox(height: 8),
              Text('indoorModel:'),
              Text(formData.indoorModel),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdditionalDetailsScreen(
                      formData: formData,
                    ),
                  ),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location List Screen'),
      ),
      body: ListView.builder(
        itemCount: savedFormData.length,
        itemBuilder: (context, index) {
          FormData formData = savedFormData[index];
          return Card(
            child: ListTile(
              onTap: () {
                _showDetailsDialog(context, formData, index);
              },
              title: Text(formData.location),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Created: ${formData.createdDate.toString()}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
