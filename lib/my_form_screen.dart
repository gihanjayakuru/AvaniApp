import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_list.dart';
import 'dart:convert';

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

  // Declare savedFormData list here
  List<Map<String, dynamic>> savedFormData = [];

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
              MaterialPageRoute(builder: (context) => LocationListScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
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
                    TextFormField(
                      controller: indoorModelController,
                      decoration: InputDecoration(labelText: 'Model'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor model';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorModelNumController,
                      decoration: InputDecoration(labelText: 'Model Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor model number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorSerialNumController,
                      decoration: InputDecoration(labelText: 'Serial Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor serial number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorCapacityController,
                      decoration: InputDecoration(labelText: 'Capacity'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor capacity';
                        }
                        return null;
                      },
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
                    TextFormField(
                      controller: outdoorModelController,
                      decoration: InputDecoration(labelText: 'Model'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoor model';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorModelNumController,
                      decoration: InputDecoration(labelText: 'Model Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoor model number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorSerialNumController,
                      decoration: InputDecoration(labelText: 'Serial Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoor serial number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorCapacityController,
                      decoration: InputDecoration(labelText: 'Capacity'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoor capacity';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              //
            ],
          ),
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
//IN HERE THE FORM NOT BE EMPTY
  // List<Map<String, dynamic>> savedFormData = [];
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

    // Get the current date and time
    DateTime now = DateTime.now();

    // Create a map of the form data
    Map<String, dynamic> formData = {
      'location': location,
      'indoorModel': indoorModel,
      'indoorModelNum': indoorModelNum,
      'indoorSerialNum': indoorSerialNum,
      'indoorCapacity': indoorCapacity,
      'outdoorModel': outdoorModel,
      'outdoorModelNum': outdoorModelNum,
      'outdoorSerialNum': outdoorSerialNum,
      'outdoorCapacity': outdoorCapacity,
      'createdDate': now.toIso8601String(),
    };

    // Save the form data to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedFormDataString = prefs.getString('savedFormData');
    if (savedFormDataString != null) {
      // Append the new form data to the existing saved form data
      List<dynamic> savedFormDataJson = jsonDecode(savedFormDataString);
      savedFormDataJson.add(formData);
      savedFormData = List<Map<String, dynamic>>.from(savedFormDataJson);
    } else {
      // Create a new list with the current form data
      savedFormData = [formData];
    }
    await prefs.setString('savedFormData', jsonEncode(savedFormData));

    // Once the data is saved, you can navigate to the list screen or perform any other actions
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationListScreen()),
    );
  }
}
