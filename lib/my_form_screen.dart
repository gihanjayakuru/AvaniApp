import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  // File? imageFile;

  File? _image;

  // This is the image picker
  final _picker = ImagePicker();

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

  // void _resetImage() {
  //   setState(() {
  //     imageFile = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime now = DateTime.now();

// Format the current date
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // Set the formatted date as the initial value for the dateController
    dateController.text = formattedDate;

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Form'),
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
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Container(
                      height: 200, // Adjust the height as per your requirement
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.black),
                      ),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.grey[300],
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                            _openImagePicker();
                          },
                          child: const Text('Add Image'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                      decoration: InputDecoration(labelText: 'Filter Clean :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the filter clean';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: blowerCheckController,
                      decoration: InputDecoration(labelText: 'Blower Check :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Blower Check';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorInspectCleanIduCoilFinsController,
                      decoration: InputDecoration(
                          labelText: 'indoor Inspect/Clean IDU Coil Fins :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the indoor Inspect/Clean IDU Coil Fins';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkCleanDrainPlateController,
                      decoration: InputDecoration(
                          labelText: 'Check/Clean Drain Plate :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Check/Clean Drain Plate';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: drainPumpCheckController,
                      decoration:
                          InputDecoration(labelText: 'Drain Pump Check :'),
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
                          labelText: 'Check Piping & Duck Insulation :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Check Piping & Duck Insulation';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: checkNoiseController,
                      decoration: InputDecoration(labelText: 'Check Noise :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Check Noise';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorHousingConditionController,
                      decoration: InputDecoration(
                          labelText: 'Indoor Housing Condition :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Indoor Housing Condition';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: indoorPcbStatusController,
                      decoration:
                          InputDecoration(labelText: 'Indoor PCB Status :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Indoor PCB Status';
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
                      decoration:
                          InputDecoration(labelText: 'Compressor Noise :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Compressor Noise';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: fanNoiseController,
                      decoration: InputDecoration(labelText: 'Fan Noise :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Fan Noise';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: outdoorInspectCleanIduCoilFinsController,
                      decoration: InputDecoration(
                          labelText: 'Outdoor Inspect/Clean IDU Coil Fins :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Outdoor Inspect/Clean IDU Coil Fins';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorPcbStatusController,
                      decoration:
                          InputDecoration(labelText: 'Outdoor PCB Status :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Outdoor PCB Status';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: outdoorHousingConditionController,
                      decoration: InputDecoration(
                          labelText: 'Outdoor Housing Condition :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Outdoor Housing Condition';
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
                      decoration: InputDecoration(
                          labelText: 'AC & Slidin Door Operation :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the AC & Slidin Door Operation';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: thermostatSettingController,
                      decoration:
                          InputDecoration(labelText: 'Thermostat Setting :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Thermostat Setting';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: drainLineCleanController,
                      decoration:
                          InputDecoration(labelText: 'Drain Line Clean :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Drain Line Clean';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: remarkController,
                      decoration: InputDecoration(labelText: 'Remark :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Remark';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(labelText: 'Date :'),
                      enabled: false, // Disable editing
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Date not loading';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: technicianNameController,
                      decoration:
                          InputDecoration(labelText: 'Technician Name :'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Technician Name';
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

  // void _selectImage() async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       imageFile = File(pickedImage.path);
  //     });
  //   }
  // }

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
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

    final isImageSaved = await DatabaseHelper.instance.saveImage(id, _image!);
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
