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
    _loadFormData2();
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

    List<String>? savedFormDataJsonList = prefs.getStringList('savedFormData');

    if (savedFormDataJsonList != null) {
      savedFormData = savedFormDataJsonList.map((formDataJson) {
        try {
          return FormData.fromJson(jsonDecode(formDataJson));
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

//
  void _deleteFormData(FormData formData) {
    setState(() {
      savedFormData.remove(formData);
    });

    _saveFormData(); // Save the updated list

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> formDataJsonList = savedFormData.map((formData) {
      return jsonEncode(formData.toJson());
    }).toList();

    prefs.setStringList('savedFormData', formDataJsonList);
  }

  void _showDeleteConfirmationDialog(BuildContext context, FormData formData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                // Perform deletion logic here
                _deleteFormData(formData);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

//
  void _showDetailsDialog(BuildContext context, FormData formData, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Location'),
                  subtitle: Text(formData.location ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Filter Clean'),
                  subtitle: Text(formData.filterClean ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Blower Check'),
                  subtitle: Text(formData.blowerCheck ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Inspect Clean IDU Coil Fins'),
                  subtitle: Text(formData.inspectCleanIduCoilFins ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Clean Drain Plate'),
                  subtitle: Text(formData.checkCleanDrainPlate ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Drain Pump Check'),
                  subtitle: Text(formData.drainPumpCheck ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Piping Duck Insulation'),
                  subtitle: Text(formData.checkPipingDuckInsulation ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Noise'),
                  subtitle: Text(formData.checkNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Indoor Housing Condition'),
                  subtitle: Text(formData.indoorHousingCondition ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('PCB Status'),
                  subtitle: Text(formData.pcbStatus ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('AC Sliding Door Operation'),
                  subtitle: Text(formData.acSlidinDoorOperation ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Thermostat Setting'),
                  subtitle: Text(formData.thermostatSetting ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Drain Line Clean'),
                  subtitle: Text(formData.drainLineClean ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Compressor Noise'),
                  subtitle: Text(formData.compressorNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Fan Noise'),
                  subtitle: Text(formData.fanNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Outdoor Housing Condition'),
                  subtitle: Text(formData.outdoorHousingCondition ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Remark'),
                  subtitle: Text(formData.remark ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Date'),
                  subtitle: Text(formData.date ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Technician Name'),
                  subtitle: Text(formData.technicianName ?? ''),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
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
              child: Text('ADD'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
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
                  Text('Created: ${formData.checkNoise}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showDeleteConfirmationDialog(context, formData);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 2) {
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
