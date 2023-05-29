import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'location_list.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MyFormScreen extends StatefulWidget {
  @override
  _MyFormScreenState createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  // Define controllers for text fields
  TextEditingController locationController = TextEditingController();
  TextEditingController filterCleanController = TextEditingController();
  TextEditingController blowerCheckController = TextEditingController();
  TextEditingController indoorInspectCleanIduCoilFinsController =
      TextEditingController();
  TextEditingController checkCleanDrainPlateController =
      TextEditingController();
  TextEditingController drainPumpCheckController = TextEditingController();
  TextEditingController checkPipingDuckInsulationController =
      TextEditingController();
  TextEditingController checkNoiseController = TextEditingController();
  TextEditingController indoorHousingConditionController =
      TextEditingController();
  TextEditingController indoorPcbStatusController = TextEditingController();
////////////////////////////////////////////////////////////////////////////
  TextEditingController compressorNoiseController = TextEditingController();
  TextEditingController fanNoiseController = TextEditingController();
  TextEditingController outdoorInspectCleanIduCoilFinsController =
      TextEditingController();
  TextEditingController outdoorPcbStatusController = TextEditingController();
  TextEditingController outdoorHousingConditionController =
      TextEditingController();
  ////////////////////////////////////////////////////////////////////
  TextEditingController acSlidinDoorOperationController =
      TextEditingController();
  TextEditingController thermostatSettingController = TextEditingController();
  TextEditingController drainLineCleanController = TextEditingController();
  /////////////////////////////////////////////////////////
  TextEditingController remarkController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController technicianNameController = TextEditingController();

  // Define form key for validation
  final _formKey = GlobalKey<FormState>();

  // Variables for handling image
  String imagePath = '';
  // Variables for handling image
  File? imageFile;

  @override
  void dispose() {
    // Dispose of controllers
    locationController.dispose();
    filterCleanController.dispose();
    blowerCheckController.dispose();
    indoorInspectCleanIduCoilFinsController.dispose();
    checkCleanDrainPlateController.dispose();
    drainPumpCheckController.dispose();
    checkPipingDuckInsulationController.dispose();
    checkNoiseController.dispose();
    indoorHousingConditionController.dispose();
    indoorPcbStatusController.dispose();
    //////////////////////////////////////////////
    compressorNoiseController.dispose();
    fanNoiseController.dispose();
    outdoorInspectCleanIduCoilFinsController.dispose();
    outdoorPcbStatusController.dispose();
    outdoorHousingConditionController.dispose();
    ////////////////////////////////
    acSlidinDoorOperationController.dispose();
    thermostatSettingController.dispose();
    drainLineCleanController.dispose();
    ////////////////////////////
    remarkController.dispose();
    dateController.dispose();
    technicianNameController.dispose();
    super.dispose();
  }

  void _resetImage() {
    setState(() {
      imageFile = null;
    });
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
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade200,
                child: imageFile == null
                    ? Center(
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            setState(() {
                              imageFile = null;
                            });
                            _selectImage();
                          },
                        ),
                      )
                    : Image.file(imageFile!),
              ),
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
              const Padding(
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
                padding: const EdgeInsets.all(16.0),
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
                      controller: indoorInspectCleanIduCoilFinsController,
                      decoration: InputDecoration(
                          labelText: 'indoorInspectCleanIduCoilFins'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoorInspectCleanIduCoilFins';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkCleanDrainPlateController,
                      decoration:
                          InputDecoration(labelText: 'checkCleanDrainPlate'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the checkCleanDrainPlate';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: drainPumpCheckController,
                      decoration: InputDecoration(labelText: 'drainPumpCheck'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the drainPumpCheck';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkPipingDuckInsulationController,
                      decoration: InputDecoration(
                          labelText: 'checkPipingDuckInsulation'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the checkPipingDuckInsulation';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkNoiseController,
                      decoration: InputDecoration(labelText: 'checkNoise'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the checkNoise';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorHousingConditionController,
                      decoration:
                          InputDecoration(labelText: 'indoorHousingCondition'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoorHousingCondition';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorPcbStatusController,
                      decoration:
                          InputDecoration(labelText: 'indoorPcbStatus '),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoorPcbStatus';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Outdoor unit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    TextFormField(
                      controller: compressorNoiseController,
                      decoration: InputDecoration(labelText: 'compressorNoise'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the compressorNoise';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: fanNoiseController,
                      decoration: InputDecoration(labelText: 'fanNoise'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the fanNoise';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: outdoorInspectCleanIduCoilFinsController,
                      decoration: InputDecoration(
                          labelText: 'outdoorInspectCleanIduCoilFins'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoorInspectCleanIduCoilFins';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorPcbStatusController,
                      decoration:
                          InputDecoration(labelText: 'outdoorPcbStatus'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoorPcbStatus';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorHousingConditionController,
                      decoration: InputDecoration(
                          labelText: 'outdoorHousingCondition '),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the outdoorHousingCondition ';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'General',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    TextFormField(
                      controller: acSlidinDoorOperationController,
                      decoration:
                          InputDecoration(labelText: 'acSlidinDoorOperation'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the acSlidinDoorOperation';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: thermostatSettingController,
                      decoration:
                          InputDecoration(labelText: 'thermostatSetting '),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the thermostatSetting';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: drainLineCleanController,
                      decoration: InputDecoration(labelText: 'drainLineClean '),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the drainLineClean';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: remarkController,
                      decoration: InputDecoration(labelText: 'remark'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the remark';
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
                      decoration: InputDecoration(labelText: 'technicianName'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the technicianName';
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

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void _saveForm() async {
    // Retrieve the form field values using the controllers
    String location = locationController.text;
    String filterClean = filterCleanController.text;
    String blowerCheck = blowerCheckController.text;
    String indoorInspectCleanIduCoilFins =
        indoorInspectCleanIduCoilFinsController.text;
    String checkCleanDrainPlate = checkCleanDrainPlateController.text;
    String drainPumpCheck = drainPumpCheckController.text;
    String checkPipingDuckInsulation = checkPipingDuckInsulationController.text;
    String checkNoise = checkNoiseController.text;
    String indoorHousingCondition = indoorHousingConditionController.text;
    String indoorPcbStatus = indoorPcbStatusController.text;
    ////////////////////////////////
    String compressorNoise = compressorNoiseController.text;
    String fanNoise = fanNoiseController.text;
    String outdoorInspectCleanIduCoilFins =
        outdoorInspectCleanIduCoilFinsController.text;
    String outdoorPcbStatus = outdoorPcbStatusController.text;
    String outdoorHousingCondition = outdoorHousingConditionController.text;
    ////////////////////////////////////
    String acSlidinDoorOperation = acSlidinDoorOperationController.text;
    String thermostatSetting = thermostatSettingController.text;
    String drainLineClean = thermostatSettingController.text;
    ///////////////////
    String remark = remarkController.text;
    String date = dateController.text;
    String technicianName = technicianNameController.text;

    // Create a map of the form data
    Map<String, dynamic> formData = {
      'location': location,
      'filterClean': filterClean,
      'blowerCheck': blowerCheck,
      'indoorInspectCleanIduCoilFins': indoorInspectCleanIduCoilFins,
      'checkCleanDrainPlate': checkCleanDrainPlate,
      'drainPumpCheck': drainPumpCheck,
      'checkPipingDuckInsulation': checkPipingDuckInsulation,
      'checkNoise': checkNoise,
      'indoorHousingCondition': indoorHousingCondition,
      'indoorPcbStatus': indoorPcbStatus,
      /////////////////////////////////
      'compressorNoise': compressorNoise,
      'fanNoise': fanNoise,
      'outdoorInspectCleanIduCoilFins': outdoorInspectCleanIduCoilFins,
      'outdoorPcbStatus': outdoorPcbStatus,
      'outdoorHousingCondition': outdoorHousingCondition,
      ///////////////////////////////////////
      'acSlidinDoorOperation': acSlidinDoorOperation,
      'thermostatSetting': thermostatSetting,
      'drainLineClean': drainLineClean,
      ///////////////////////////
      'remark': remark,
      'date': date,
      'technicianName': technicianName,
    };

    // Save the form data in SQLite
    int id = await DatabaseHelper.instance.insertFormData(formData);
    print('Form data saved with ID: $id');

    final isImageSaved =
        await DatabaseHelper.instance.saveImage(id, imageFile!);
    if (isImageSaved) {
      // Image data was inserted successfully
      print(' Image data was inserted successfully');
    } else {
      // Image data insertion failed
      print('Image data insertion failed');
    }
// // Save the image file
//     if (imageFile != null) {
//       await DatabaseHelper.instance.saveImage(id, imageFile!);
//       print('Image saved for form ID: $id');
//     }
    // Clear the form fields
    _clearForm();

    // Once the data is saved, you can navigate to the list screen or perform any other actions
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationListScreen()),
    );
  }

  void _clearForm() {
    locationController.clear();
    filterCleanController.clear();
    blowerCheckController.clear();
    indoorInspectCleanIduCoilFinsController.clear();
    checkCleanDrainPlateController.clear();
    drainPumpCheckController.clear();
    checkPipingDuckInsulationController.clear();
    checkNoiseController.clear();
    indoorHousingConditionController.clear();
    indoorPcbStatusController.clear();
    ////////////////////////////////
    compressorNoiseController.clear();
    fanNoiseController.clear();
    outdoorInspectCleanIduCoilFinsController.clear();
    outdoorPcbStatusController.clear();
    outdoorHousingConditionController.clear();
    ////////////////////////////////////
    acSlidinDoorOperationController.clear();
    thermostatSettingController.clear();
    thermostatSettingController.clear();
    ///////////////////
    remarkController.clear();
    dateController.clear();
    technicianNameController.clear();
  }
}
