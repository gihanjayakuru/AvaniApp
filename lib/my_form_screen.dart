import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  TextEditingController filterCleanController = TextEditingController();
  TextEditingController blowerCheckController = TextEditingController();
  TextEditingController inspectCleanIduCoilFinsController =
      TextEditingController();
  TextEditingController checkCleanDrainPlateController =
      TextEditingController();
  TextEditingController drainPumpCheckController = TextEditingController();
  TextEditingController checkPipingDuckInsulationController =
      TextEditingController();
  TextEditingController checkNoiseController = TextEditingController();
  TextEditingController indoorHousingConditionController =
      TextEditingController();
  TextEditingController pcbStatusController = TextEditingController();
  TextEditingController acSlidinDoorOperationController =
      TextEditingController();
  TextEditingController thermostatSettingController = TextEditingController();
  TextEditingController drainLineCleanController = TextEditingController();
  TextEditingController compressorNoiseController = TextEditingController();
  TextEditingController fanNoiseController = TextEditingController();
  TextEditingController outdoorHousingConditionController =
      TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController technicianNameController = TextEditingController();

  // Declare savedFormData list here
  List<Map<String, dynamic>> savedFormData = [];

  // Define form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose of controllers
    locationController.dispose();
    filterCleanController.dispose();
    blowerCheckController.dispose();
    inspectCleanIduCoilFinsController.dispose();
    checkCleanDrainPlateController.dispose();
    drainPumpCheckController.dispose();
    checkPipingDuckInsulationController.dispose();
    checkNoiseController.dispose();
    indoorHousingConditionController.dispose();
    pcbStatusController.dispose();
    acSlidinDoorOperationController.dispose();
    thermostatSettingController.dispose();
    drainLineCleanController.dispose();
    compressorNoiseController.dispose();
    fanNoiseController.dispose();
    outdoorHousingConditionController.dispose();
    remarkController.dispose();
    dateController.dispose();
    technicianNameController.dispose();
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
                      controller: filterCleanController,
                      decoration: InputDecoration(labelText: 'filterClean'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the filterClean';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: blowerCheckController,
                      decoration: InputDecoration(labelText: 'blowerCheck'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the blowerCheck';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: inspectCleanIduCoilFinsController,
                      decoration: InputDecoration(labelText: 'Serial Number'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor serial number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkCleanDrainPlateController,
                      decoration: InputDecoration(
                          labelText: 'checkCleanDrainPlateController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the checkCleanDrainPlateController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: drainPumpCheckController,
                      decoration: InputDecoration(
                          labelText: 'drainPumpCheckController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the drainPumpCheckController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkPipingDuckInsulationController,
                      decoration: InputDecoration(
                          labelText: 'checkPipingDuckInsulationController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the checkPipingDuckInsulationController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkNoiseController,
                      decoration:
                          InputDecoration(labelText: 'checkNoiseController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the checkNoiseController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorHousingConditionController,
                      decoration: InputDecoration(
                          labelText: 'indoorHousingConditionController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoorHousingConditionController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: pcbStatusController,
                      decoration:
                          InputDecoration(labelText: 'pcbStatusController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the pcbStatusController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: acSlidinDoorOperationController,
                      decoration: InputDecoration(
                          labelText: 'acSlidinDoorOperationController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the acSlidinDoorOperationController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: thermostatSettingController,
                      decoration: InputDecoration(
                          labelText: 'thermostatSettingController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the thermostatSettingController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: drainLineCleanController,
                      decoration: InputDecoration(
                          labelText: 'drainLineCleanController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the drainLineCleanController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: compressorNoiseController,
                      decoration: InputDecoration(
                          labelText: 'compressorNoiseController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the compressorNoiseController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: fanNoiseController,
                      decoration:
                          InputDecoration(labelText: 'fanNoiseController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the fanNoiseController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorHousingConditionController,
                      decoration: InputDecoration(
                          labelText: 'outdoorHousingConditionController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoorHousingConditionController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: remarkController,
                      decoration:
                          InputDecoration(labelText: 'remarkController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the remarkController';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(labelText: 'Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date not loading';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: technicianNameController,
                      decoration: InputDecoration(
                          labelText: 'technicianNameController'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the technicianNameController';
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
    print("object");

    // Retrieve the form field values using the controllers
    String location = locationController.text;
    String filterClean = filterCleanController.text;
    String blowerCheck = blowerCheckController.text;
    String inspectCleanIduCoilFins = inspectCleanIduCoilFinsController.text;
    String checkCleanDrainPlate = checkCleanDrainPlateController.text;
    String drainPumpCheck = drainPumpCheckController.text;
    String checkPipingDuckInsulation = checkPipingDuckInsulationController.text;
    String checkNoise = checkNoiseController.text;
    String indoorHousingCondition = indoorHousingConditionController.text;
    String pcbStatus = pcbStatusController.text;

    String acSlidinDoorOperation = acSlidinDoorOperationController.text;
    String thermostatSetting = thermostatSettingController.text;
    String drainLineClean = drainLineCleanController.text;

    String compressorNoise = compressorNoiseController.text;
    String fanNoise = fanNoiseController.text;
    String outdoorHousingCondition = outdoorHousingConditionController.text;
    String remark = remarkController.text;
    String date = dateController.text;
    String technicianName = technicianNameController.text;

    // Create a map of the form data
    Map<String, dynamic> formData = {
      'location': location,
      'filterClean': filterClean,
      'blowerCheck': blowerCheck,
      'inspectCleanIduCoilFins': inspectCleanIduCoilFins,
      'checkCleanDrainPlate': checkCleanDrainPlate,
      'drainPumpCheck': drainPumpCheck,
      'checkPipingDuckInsulation': checkPipingDuckInsulation,
      'checkNoise': checkNoise,
      'indoorHousingCondition': indoorHousingCondition,
      'pcbStatus': pcbStatus,
      'acSlidinDoorOperation': acSlidinDoorOperation,
      'thermostatSetting': thermostatSetting,
      'drainLineClean': drainLineClean,
      'compressorNoise': compressorNoise,
      'fanNoise': fanNoise,
      'outdoorHousingCondition': outdoorHousingCondition,
      'remark': remark,
      'date': date,
      'technicianName': technicianName,
    };

    print(formData);

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
