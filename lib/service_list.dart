import 'dart:io';

import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'location_list.dart';
import 'service_data.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  List<MergedData> savedServiceFormData = [];

  @override
  void initState() {
    super.initState();
    _loadServiceFormData();
  }

  @override
  void dispose() {
    // Close the database connection
    DatabaseHelper.instance.closeDatabase();
    super.dispose();
  }

  void _loadServiceFormData() async {
    List<Map<String, dynamic>> serviceFormDataList =
        await DatabaseHelper.instance.getServiceFormDataList();

    savedServiceFormData = serviceFormDataList
        .map((formData) => MergedData.fromJson(formData))
        .toList();

    setState(() {});
  }

  void _deleteServiceFormData(int id) async {
    await DatabaseHelper.instance.deleteServiceFormData(id);

    _loadServiceFormData();
  }

  void _showServiceDetailsDialog(MergedData serviceFormData, context) async {
    List<Map<String, dynamic>> serviceImages = await DatabaseHelper.instance
        .getServiceImagesForForm(serviceFormData.id);

    print("Service list load with this id${serviceFormData.id}");

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Before After Service Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location : ${serviceFormData.location}'),
                Text('Date : ${serviceFormData.createdDate}'),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Before Service',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'Room Temperature : ${serviceFormData.beforeRoomTemperature}'),
                Text(
                    'Set Point Temperature : ${serviceFormData.beforeSetPointTemperature}'),
                Text(
                    'Supply Grill Temperature : ${serviceFormData.beforeSupplyGrillTemperature}'),
                Text(
                    'Return Grill Temperature : ${serviceFormData.beforeReturnGrillTemperature}'),
                Text(
                    'Gas Pressure /Low Side : ${serviceFormData.beforeGasPressureLowSide}'),
                Text(
                    'Gas Pressure /High Side : ${serviceFormData.beforeGasPressureHighSide}'),
                Text('Amp : ${serviceFormData.beforeAmp}'),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'After Service',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'Room Temperature : ${serviceFormData.afterRoomTemperature}'),
                Text(
                    'Set Point Temperature : ${serviceFormData.afterSetPointTemperature}'),
                Text(
                    'Supply Grill Temperature : ${serviceFormData.afterSupplyGrillTemperature}'),
                Text(
                    'Return Grill Temperature : ${serviceFormData.afterReturnGrillTemperature}'),
                Text(
                    'Gas Pressure /Low Side: ${serviceFormData.afterGasPressureLowSide}'),
                Text(
                    'Gas Pressure /High Side : ${serviceFormData.afterGasPressureHighSide}'),
                Text('Amp : ${serviceFormData.afterAmp}'),
                if (serviceImages.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Service Images',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (serviceImages.isNotEmpty)
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: serviceImages.map((imageData) {
                      final String imagePath = imageData['image_path'];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(File(imagePath), fit: BoxFit.cover),
                      );
                    }).toList(),
                  ),
                if (serviceImages.isEmpty) Text('No images available'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
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
        title: Text('Service List Screen'),
      ),
      body: ListView.builder(
        itemCount: savedServiceFormData.length,
        itemBuilder: (context, index) {
          MergedData serviceFormData = savedServiceFormData[index];
          return Card(
            child: ListTile(
              onTap: () {
                _showServiceDetailsDialog(serviceFormData, context);
              },
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location : ${serviceFormData.location}'),
                  Text('Date : ${serviceFormData.createdDate}'),
                  Text(
                      'Before Temperature : ${serviceFormData.beforeRoomTemperature}'),
                  Text(
                      'After Temperature : ${serviceFormData.afterRoomTemperature}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteServiceFormData(serviceFormData.id),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 1) {
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
