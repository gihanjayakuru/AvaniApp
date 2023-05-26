import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String? _location;
  String? _indoorModel;
  String? _indoorModelNum;
  String? _indoorSerialNum;
  String? _indoorCapacity;
  String? _outdoorModel;
  String? _outdoorModelNum;
  String? _outdoorSerialNum;
  String? _outdoorCapacity;

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  void _loadFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the form data using the keys used to save them
    _location = prefs.getString('location');
    _indoorModel = prefs.getString('indoorModel');
    _indoorModelNum = prefs.getString('indoorModelNum');
    _indoorSerialNum = prefs.getString('indoorSerialNum');
    _indoorCapacity = prefs.getString('indoorCapacity');
    _outdoorModel = prefs.getString('outdoorModel');
    _outdoorModelNum = prefs.getString('outdoorModelNum');
    _outdoorSerialNum = prefs.getString('outdoorSerialNum');
    _outdoorCapacity = prefs.getString('outdoorCapacity');

    setState(() {
      // State is updated to trigger a rebuild and display the retrieved data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Location'),
              subtitle: Text(_location ?? ''),
            ),
            ListTile(
              title: Text('Indoor Model'),
              subtitle: Text(_indoorModel ?? ''),
            ),
            ListTile(
              title: Text('Indoor Model Number'),
              subtitle: Text(_indoorModelNum ?? ''),
            ),
            ListTile(
              title: Text('Indoor Serial Number'),
              subtitle: Text(_indoorSerialNum ?? ''),
            ),
            ListTile(
              title: Text('Indoor Capacity'),
              subtitle: Text(_indoorCapacity ?? ''),
            ),
            ListTile(
              title: Text('Outdoor Model'),
              subtitle: Text(_outdoorModel ?? ''),
            ),
            ListTile(
              title: Text('Outdoor Model Number'),
              subtitle: Text(_outdoorModelNum ?? ''),
            ),
            ListTile(
              title: Text('Outdoor Serial Number'),
              subtitle: Text(_outdoorSerialNum ?? ''),
            ),
            ListTile(
              title: Text('Outdoor Capacity'),
              subtitle: Text(_outdoorCapacity ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
