import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormData {
  String location;
  String indoorModel;
  String indoorModelNum;
  String indoorSerialNum;
  String indoorCapacity;
  String outdoorModel;
  String outdoorModelNum;
  String outdoorSerialNum;
  String outdoorCapacity;
  DateTime createdDate;

  FormData({
    required this.location,
    required this.indoorModel,
    required this.indoorModelNum,
    required this.indoorSerialNum,
    required this.indoorCapacity,
    required this.outdoorModel,
    required this.outdoorModelNum,
    required this.outdoorSerialNum,
    required this.outdoorCapacity,
    required this.createdDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'indoorModel': indoorModel,
      'indoorModelNum': indoorModelNum,
      'indoorSerialNum': indoorSerialNum,
      'indoorCapacity': indoorCapacity,
      'outdoorModel': outdoorModel,
      'outdoorModelNum': outdoorModelNum,
      'outdoorSerialNum': outdoorSerialNum,
      'outdoorCapacity': outdoorCapacity,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      location: json['location'],
      indoorModel: json['indoorModel'],
      indoorModelNum: json['indoorModelNum'],
      indoorSerialNum: json['indoorSerialNum'],
      indoorCapacity: json['indoorCapacity'],
      outdoorModel: json['outdoorModel'],
      outdoorModelNum: json['outdoorModelNum'],
      outdoorSerialNum: json['outdoorSerialNum'],
      outdoorCapacity: json['outdoorCapacity'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }
}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

// class _ListScreenState extends State<ListScreen> {
//   List<FormData> savedFormData = [];
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
          title: Text('Add Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add your additional input fields here
              TextField(
                decoration: InputDecoration(labelText: 'Additional Field 1'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Additional Field 2'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Save the additional details and update the savedFormData
                // or perform any other desired action
                setState(() {
                  selectedFormData = null;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedFormData = null;
                });
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
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
              title: Text('Location'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formData.location),
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
