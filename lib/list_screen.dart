import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'additional_details_screen.dart';
import 'form_data.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<FormData> savedFormData = [];
  FormData? selectedFormData;

  @override
  void initState() {
    super.initState();
    _loadFormData();
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

  void _showDetailsDialog(BuildContext context, FormData formData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Additional Details'),
          content: Text('Would you like to add more details?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdditionalDetailsScreen(
                      formData: formData,
                      serviceDetails: [], // Provide service details as needed
                      mergedFormDataList: [], // Provide merged form data as needed
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
        title: Text('List Screen'),
      ),
      body: ListView.builder(
        itemCount: savedFormData.length,
        itemBuilder: (context, index) {
          FormData formData = savedFormData[index];
          return Card(
            child: ListTile(
              onTap: () {
                setState(() {
                  selectedFormData = formData;
                });
                _showDetailsDialog(context, formData);
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
