import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'avani_data.db'),
    );

    List<Map<String, dynamic>> serviceFormDataList =
        await database.query('service_form_data');

    savedServiceFormData = serviceFormDataList
        .map((formData) => MergedData.fromJson(formData))
        .toList();

    await database.close();

    setState(() {});
  }

  void _deleteServiceFormData(int id) async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'avani_data.db'),
    );

    await database.delete(
      'service_form_data',
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();

    _loadServiceFormData();
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
                  Text('serviceType: ${serviceFormData.afterAmp}'),
                  Text(
                      'serviceDescription: ${serviceFormData.afterGasPressureHighSide}'),
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
