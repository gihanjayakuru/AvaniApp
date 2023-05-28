import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'additional_details_screen.dart';
import 'form_data.dart';
import 'service_list.dart';

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
  void _loadFormData2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedFormDataJson = prefs.getString('savedFormData');

    if (savedFormDataJson != null) {
      List<dynamic> formDataList = jsonDecode(savedFormDataJson);
      savedFormData = formDataList.map((formDataJson) {
        try {
          return FormData.fromJson(formDataJson);
        } catch (e) {
          // Error occurred during parsing, handle it accordingly
          print('Error parsing FormData: $e');
          return FormData(
            location: '', // Provide default value or handle differently
            filterClean: '',
            blowerCheck: '',
            inspectCleanIduCoilFins: '',
            checkCleanDrainPlate: '',
            drainPumpCheck: '',
            checkPipingDuckInsulation: '',
            checkNoise: '',
            indoorHousingCondition: '',
            pcbStatus: '',
            acSlidinDoorOperation: '',
            thermostatSetting: '',
            drainLineClean: '',
            compressorNoise: '',
            fanNoise: '',
            outdoorHousingCondition: '',
            remark: '',
            date: '',
            technicianName: '',
          );
        }
      }).toList();
    } else {
      savedFormData = []; // Handle case where no data is saved
    }

    setState(() {
      // Trigger a rebuild to display the retrieved data
    });
  }

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
              Text('Created: ${formData.blowerCheck}'),
              SizedBox(height: 8),
              Text('indoorModel:'),
              Text(formData.checkNoise),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.pop(context); // Close the dialog
                Navigator.popUntil(context, (route) => route.isFirst);
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Location List Screen'),
  //     ),
  //     body: ListView.builder(
  //       itemCount: savedFormData.length,
  //       itemBuilder: (context, index) {
  //         FormData formData = savedFormData[index];
  //         return Card(
  //           child: ListTile(
  //             onTap: () {
  //               _showDetailsDialog(context, formData, index);
  //             },
  //             title: Text(formData.location),
  //             subtitle: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text('Created: ${formData.createdDate.toString()}'),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

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
                  Text('Created: ${formData.checkNoise}'),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the index of the current screen
        onTap: (int index) {
          if (index == 0) {
            // Navigate to HomeScreen
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 2) {
            // Navigate to ServiceListScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ServiceListScreen()),
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
