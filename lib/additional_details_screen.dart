import 'package:avani_app/service_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'form_data.dart';
import 'location_list.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  final FormData formData;

  AdditionalDetailsScreen({required this.formData});

  @override
  _AdditionalDetailsScreenState createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  // Define controllers for text fields
  TextEditingController beforeRoomTemperatureController =
      TextEditingController();
  TextEditingController beforeSetPointTemperatureController =
      TextEditingController();
  TextEditingController beforeSupplyGrillTemperatureController =
      TextEditingController();
  TextEditingController beforeReturnGrillTemperatureController =
      TextEditingController();
  TextEditingController beforeGasPressureLowSideController =
      TextEditingController();
  TextEditingController beforeGasPressureHighSideController =
      TextEditingController();
  TextEditingController beforeAmpController = TextEditingController();
  TextEditingController afterRoomTemperatureController =
      TextEditingController();
  TextEditingController afterSetPointTemperatureController =
      TextEditingController();
  TextEditingController afterSupplyGrillTemperatureController =
      TextEditingController();
  TextEditingController afterReturnGrillTemperatureController =
      TextEditingController();
  TextEditingController afterGasPressureLowSideController =
      TextEditingController();
  TextEditingController afterGasPressureHighSideController =
      TextEditingController();
  TextEditingController afterAmpController = TextEditingController();

  // Define form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of controllers
    beforeRoomTemperatureController.dispose();
    beforeSetPointTemperatureController.dispose();
    beforeSupplyGrillTemperatureController.dispose();
    beforeReturnGrillTemperatureController.dispose();
    beforeGasPressureLowSideController.dispose();
    beforeGasPressureHighSideController.dispose();
    beforeAmpController.dispose();
    afterRoomTemperatureController.dispose();
    afterSetPointTemperatureController.dispose();
    afterSupplyGrillTemperatureController.dispose();
    afterReturnGrillTemperatureController.dispose();
    afterGasPressureLowSideController.dispose();
    afterGasPressureHighSideController.dispose();
    afterAmpController.dispose();
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
                child: Text(
                  'Location : ${widget.formData.location}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Before Service :',
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
                      controller: beforeRoomTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'Before Room Temperature :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the Before Room Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: beforeSetPointTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'Before Set Point Temperature :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Before Set Point Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: beforeSupplyGrillTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'Before Supply Grill Temperature :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the Before Supply Grill Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: beforeReturnGrillTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'Before Return Grill Temperature :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Before Return Grill Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: beforeGasPressureLowSideController,
                      decoration: InputDecoration(
                          labelText: 'Before Gas Pressure /Low Side :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the Before Gas Pressure /Low Side';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: beforeGasPressureHighSideController,
                      decoration: InputDecoration(
                          labelText: 'Before Gas Pressure /High Side :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Before Gas Pressure /High Side ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: beforeAmpController,
                      decoration: InputDecoration(labelText: 'Before Amp :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the Before Amp';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'After Service :',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: afterRoomTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'After Room Temperature :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the After Room Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: afterSetPointTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'After Set Point Temperature :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the After Set Point Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: afterSupplyGrillTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'After Supply Grill Temperature :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the After Supply Grill Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: afterReturnGrillTemperatureController,
                      decoration: InputDecoration(
                          labelText: 'After Return Grill Temperature :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the After Return Grill Temperature';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: afterGasPressureLowSideController,
                      decoration: InputDecoration(
                          labelText: 'After Gas Pressure /Low Side'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the After Gas Pressure /Low Side';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: afterGasPressureHighSideController,
                      decoration: InputDecoration(
                          labelText: 'After Gas Pressure /High Side :'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the After Gas Pressure /High Side';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: afterAmpController,
                      decoration:
                          InputDecoration(labelText: 'After Amp Controller :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the After Amp Controller';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

  void _saveForm() async {
    // Retrieve the form field values using the controllers
    String location = widget.formData.location ?? '';
    String beforeRoomTemperature = beforeRoomTemperatureController.text;
    String beforeSetPointTemperature = beforeSetPointTemperatureController.text;
    String beforeSupplyGrillTemperature =
        beforeSupplyGrillTemperatureController.text;
    String beforeReturnGrillTemperature =
        beforeReturnGrillTemperatureController.text;
    String beforeGasPressureLowSide = beforeGasPressureLowSideController.text;
    String beforeGasPressureHighSide = beforeGasPressureHighSideController.text;
    String beforeAmp = beforeAmpController.text;
    String afterRoomTemperature = afterRoomTemperatureController.text;
    String afterSetPointTemperature = afterSetPointTemperatureController.text;
    String afterSupplyGrillTemperature =
        afterSupplyGrillTemperatureController.text;
    String afterReturnGrillTemperature =
        afterReturnGrillTemperatureController.text;
    String afterGasPressureLowSide = afterGasPressureLowSideController.text;
    String afterGasPressureHighSide = afterGasPressureHighSideController.text;
    String afterAmp = afterAmpController.text;

    // Get the current date and time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    // Create a map of the form data
    Map<String, dynamic> serviceFormData = {
      'createdDate': formattedDate,
      'location': location,
      'beforeRoomTemperature': beforeRoomTemperature,
      'beforeSetPointTemperature': beforeSetPointTemperature,
      'beforeSupplyGrillTemperature': beforeSupplyGrillTemperature,
      'beforeReturnGrillTemperature': beforeReturnGrillTemperature,
      'beforeGasPressureLowSide': beforeGasPressureLowSide,
      'beforeGasPressureHighSide': beforeGasPressureHighSide,
      'beforeAmp': beforeAmp,
      'afterRoomTemperature': afterRoomTemperature,
      'afterSetPointTemperature': afterSetPointTemperature,
      'afterSupplyGrillTemperature': afterSupplyGrillTemperature,
      'afterReturnGrillTemperature': afterReturnGrillTemperature,
      'afterGasPressureLowSide': afterGasPressureLowSide,
      'afterGasPressureHighSide': afterGasPressureHighSide,
      'afterAmp': afterAmp,
    };

    // Save the form data using your existing DatabaseHelper class
    await DatabaseHelper.instance.insertServiceFormData(serviceFormData);

    // Once the data is saved, you can navigate to the list screen or perform any other actions
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ServiceListScreen()),
    );
  }
}
