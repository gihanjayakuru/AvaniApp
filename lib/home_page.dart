import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_screen.dart';

class MyFormScreen extends StatefulWidget {
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  // Define controllers for text fields
  TextEditingController locationController = TextEditingController();
  TextEditingController indoorModelController = TextEditingController();
  TextEditingController indoorModelNumController = TextEditingController();
  TextEditingController indoorSerialNumController = TextEditingController();
  TextEditingController indoorCapacityController = TextEditingController();
  TextEditingController outdoorModelController = TextEditingController();
  TextEditingController outdoorModelNumController = TextEditingController();
  TextEditingController outdoorSerialNumController = TextEditingController();
  TextEditingController outdoorCapacityController = TextEditingController();

  // Define form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of controllers
    locationController.dispose();
    indoorModelController.dispose();
    indoorModelNumController.dispose();
    indoorSerialNumController.dispose();
    indoorCapacityController.dispose();
    outdoorModelController.dispose();
    outdoorModelNumController.dispose();
    outdoorSerialNumController.dispose();
    outdoorCapacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Indoor unit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: indoorModelController,
                    decoration: InputDecoration(labelText: 'Model'),
                  ),
                  TextField(
                    controller: indoorModelNumController,
                    decoration: InputDecoration(labelText: 'Model Number'),
                  ),
                  TextField(
                    controller: indoorSerialNumController,
                    decoration: InputDecoration(labelText: 'Serial Number'),
                  ),
                  TextField(
                    controller: indoorCapacityController,
                    decoration: InputDecoration(labelText: 'Capacity'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Outdoor unit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: outdoorModelController,
                    decoration: InputDecoration(labelText: 'Model'),
                  ),
                  TextField(
                    controller: outdoorModelNumController,
                    decoration: InputDecoration(labelText: 'Model Number'),
                  ),
                  TextField(
                    controller: outdoorSerialNumController,
                    decoration: InputDecoration(labelText: 'Serial Number'),
                  ),
                  TextField(
                    controller: outdoorCapacityController,
                    decoration: InputDecoration(labelText: 'Capacity'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /////////
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              // Form is valid, save the data
              _saveForm();
            }
          },
          child: Text('Save'),
        ),
      ),
    );
  }

  // );
  // }
// }
  void _saveForm() async {
    // Retrieve the form field values using the controllers
    String location = locationController.text;
    String indoorModel = indoorModelController.text;
    String indoorModelNum = indoorModelNumController.text;
    String indoorSerialNum = indoorSerialNumController.text;
    String indoorCapacity = indoorCapacityController.text;
    String outdoorModel = outdoorModelController.text;
    String outdoorModelNum = outdoorModelNumController.text;
    String outdoorSerialNum = outdoorSerialNumController.text;
    String outdoorCapacity = outdoorCapacityController.text;

    // Save the form data to shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('location', location);
    await prefs.setString('indoorModel', indoorModel);
    await prefs.setString('indoorModelNum', indoorModelNum);
    await prefs.setString('indoorSerialNum', indoorSerialNum);
    await prefs.setString('indoorCapacity', indoorCapacity);
    await prefs.setString('outdoorModel', outdoorModel);
    await prefs.setString('outdoorModelNum', outdoorModelNum);
    await prefs.setString('outdoorSerialNum', outdoorSerialNum);
    await prefs.setString('outdoorCapacity', outdoorCapacity);

    // Once the data is saved, you can navigate to the list screen or perform any other actions
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListScreen()),
    );
  }
}
